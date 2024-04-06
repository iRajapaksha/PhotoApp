from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer
from transformers import T5ForConditionalGeneration, T5Tokenizer
import torch
from PIL import Image


# Load pre-trained models and tokenizers
def load_models():
    # Image captioning model
    image_caption_model_name = "nlpconnect/vit-gpt2-image-captioning"
    image_caption_model = VisionEncoderDecoderModel.from_pretrained(image_caption_model_name)
    image_caption_tokenizer = AutoTokenizer.from_pretrained(image_caption_model_name)

    # T5 paraphrasing model
    t5_model_name = "t5-base"
    model_paraphrasing = T5ForConditionalGeneration.from_pretrained(t5_model_name)
    tokenizer_paraphrasing = T5Tokenizer.from_pretrained(t5_model_name)

    return image_caption_model, image_caption_tokenizer, model_paraphrasing, tokenizer_paraphrasing


# Load models
image_caption_model, image_caption_tokenizer, model_paraphrasing, tokenizer_paraphrasing = load_models()


# Function to predict image captions
def predict_image_caption(image_paths):
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    feature_extractor = ViTFeatureExtractor.from_pretrained("nlpconnect/vit-gpt2-image-captioning")

    images = [Image.open(image_path).convert("RGB") for image_path in image_paths]
    pixel_values = feature_extractor(images=images, return_tensors="pt").pixel_values.to(device)
    attention_mask = torch.ones(pixel_values.shape[:2], dtype=torch.long, device=device)
    output_ids = image_caption_model.generate(pixel_values, attention_mask=attention_mask, max_length=16, num_beams=4)
    preds = image_caption_tokenizer.batch_decode(output_ids, skip_special_tokens=True)

    return preds


# Function to preprocess text
def preprocess_text(text):
    # Remove punctuation and extra spaces
    text = text.replace(",", "").replace(".", "").replace(";", "").replace(":", "").strip()
    return text


# Function to generate paraphrases with similar words
def paraphrase_with_similar_words(input_text, num_outputs=5):
    input_ids = tokenizer_paraphrasing.encode(input_text, return_tensors="pt")
    outputs = model_paraphrasing.generate(input_ids, num_return_sequences=num_outputs, max_length=50, num_beams=5)
    paraphrases = [tokenizer_paraphrasing.decode(output, skip_special_tokens=True) for output in outputs]
    return paraphrases


# Function to paraphrase text with T5 model
def paraphrase_with_t5(input_text, num_outputs=5, temperature=1.0, top_k=50, top_p=0.95):
    input_text = preprocess_text(input_text)

    inputs = tokenizer_paraphrasing.encode("paraphrase: " + input_text, return_tensors="pt", max_length=512,
                                           truncation=True)
    paraphrased_output = model_paraphrasing.generate(
        inputs,
        num_return_sequences=num_outputs,
        max_length=60,
        temperature=temperature,
        do_sample=True,
        top_k=top_k,
        top_p=top_p,
        early_stopping=True
    )
    # Remove duplicate paraphrases
    paraphrased_texts = list(
        set([tokenizer_paraphrasing.decode(output, skip_special_tokens=True) for output in paraphrased_output]))

    # Filter out very similar paraphrases
    unique_paraphrases = filter_similar_paraphrases(paraphrased_texts)

    return unique_paraphrases


def filter_similar_paraphrases(paraphrases, similarity_threshold=0.2):
    unique_paraphrases = []
    for paraphrase in paraphrases:
        is_unique = True
        for unique_paraphrase in unique_paraphrases:
            similarity = calculate_similarity(paraphrase, unique_paraphrase)
            if similarity > similarity_threshold:
                is_unique = False
                break
        if is_unique:
            unique_paraphrases.append(paraphrase)
    return unique_paraphrases


def calculate_similarity(text1, text2):
    words1 = set(text1.split())
    words2 = set(text2.split())
    intersection = len(words1.intersection(words2))
    union = len(words1.union(words2))
    similarity = intersection / union
    return similarity


# Example usage
image_paths = ['Test_Data/476759700_8911f087f8.jpg']
predicted_captions = predict_image_caption(image_paths)
input_caption = predicted_captions[-1]  # Selecting the first caption from the list
print("Original Caption:", input_caption)

# Generate paraphrases with similar words
paraphrases_similar_words = paraphrase_with_similar_words(input_caption, num_outputs=5)
print("Paraphrases with Similar Words:")
for i, paraphrase in enumerate(paraphrases_similar_words):
    print(f"{i + 1}. {paraphrase}")


