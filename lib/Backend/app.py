from flask import Flask, request, jsonify
import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
import cv2
from keras.applications import ResNet50
from keras.applications.resnet50 import preprocess_input
from keras.models import Model
from keras.layers import GlobalAveragePooling2D
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)

def load_images(image_paths):
    images = []
    for image_path in image_paths:
        image = cv2.imread(image_path)
        if image is None:
            return None, f"Image {image_path} could not be loaded"
        images.append((image_path, image))
    return images, None

def extract_resnet50_features(images):
    base_model = ResNet50(weights='imagenet', include_top=False)
    model = Model(inputs=base_model.input, outputs=GlobalAveragePooling2D()(base_model.output))
    feature_vectors = [model.predict(preprocess_input(cv2.resize(image, (224, 224))).reshape(1, 224, 224, 3)).flatten()
                       for _, image in images]
    return feature_vectors

def detect_similar_images(image_files, feature_vectors):
    similar_images = []
    processed_images = set()
    num_images = len(image_files)
    for i in range(num_images):
        if image_files[i] not in processed_images:
            group = []
            for j in range(num_images):
                if i != j:
                    similarity_score = cosine_similarity([feature_vectors[i]], [feature_vectors[j]])[0][0]
                    if similarity_score > 0.80:
                        group.append(image_files[j])
                        processed_images.add(image_files[j])
            if group:
                group.append(image_files[i])
                similar_images.append(group)
                processed_images.add(image_files[i])
    return similar_images

@app.route('/find_similar_images', methods=['POST'])
def find_similar_images():
    if 'images' not in request.json:
        return jsonify({'error': 'Images not provided'}), 400

    image_paths = request.json['images']
    for image_path in image_paths:
        if not os.path.exists(image_path):
            return jsonify({'error': f'Image {image_path} does not exist'}), 400

    images, error = load_images(image_paths)
    if error:
        return jsonify({'error': error}), 400

    feature_vectors = extract_resnet50_features(images)
    similar_image_groups = detect_similar_images([image[0] for image in images], feature_vectors)

    return jsonify({'similar_images': similar_image_groups})

@app.route('/')
def home():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
