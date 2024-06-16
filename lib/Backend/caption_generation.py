from flask import Flask, request, jsonify
from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer
import torch
from PIL import Image
import io

# Initialize the Flask app
app = Flask(__name__)

# Load pre-trained models and tokenizers
def load_models():
    # Image captioning model
    image_caption_model_name = "nlpconnect/vit-gpt2-image-captioning"
    image_caption_model = VisionEncoderDecoderModel.from_pretrained(image_caption_model_name)
    image_caption_tokenizer = AutoTokenizer.from_pretrained(image_caption_model_name)

    # Move the model to the appropriate device (CPU or GPU)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    image_caption_model.to(device)

    return image_caption_model, image_caption_tokenizer, device

# Load models and device
image_caption_model, image_caption_tokenizer, device = load_models()

# Function to predict image captions
def predict_image_caption(image):
    feature_extractor = ViTFeatureExtractor.from_pretrained("nlpconnect/vit-gpt2-image-captioning")

    # Convert image to RGB if not already
    image = image.convert("RGB")
    
    # Preprocess image
    pixel_values = feature_extractor(images=[image], return_tensors="pt").pixel_values.to(device)
    
    # Generate attention mask
    attention_mask = torch.ones(pixel_values.shape[:2], dtype=torch.long, device=device)
    
    # Generate the caption
    output_ids = image_caption_model.generate(pixel_values, attention_mask=attention_mask, max_length=16, num_beams=4)
    
    # Decode the generated ids to get the caption
    preds = image_caption_tokenizer.batch_decode(output_ids, skip_special_tokens=True)
    
    return preds[0]

# Define the route for the API
@app.route('/generate_caption', methods=['POST'])
def generate_caption():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image_file = request.files['image']
    
    try:
        image = Image.open(io.BytesIO(image_file.read()))
    except IOError:
        return jsonify({'error': 'Invalid image format'}), 400

    caption = predict_image_caption(image)

    return jsonify({'caption': caption})

@app.route('/')
def home():
    return 'Caption generation service is running!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)
