import os
import cv2
import numpy as np
from flask import Flask, request, jsonify, redirect, url_for
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'jpg', 'jpeg', 'png', 'jfif', 'webp'}
app.config['THRESHOLD'] = 1600000  # Adjust this threshold as needed

if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']


def calculate_gradient_magnitude(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=3)
    grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=3)
    gradient_magnitude = cv2.magnitude(grad_x, grad_y)
    return cv2.mean(gradient_magnitude)[0]


def calculate_gaussian_blur(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    return cv2.Laplacian(gray, cv2.CV_64F).var()


def calculate_canny_edge(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray, 50, 150)
    return cv2.mean(edges)[0] / 255


def calculate_pixel_distribution(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    hist = cv2.calcHist([gray], [0], None, [256], [0, 256])
    return np.sum(hist[1:]) / np.sum(hist)


def calculate_smoothness(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    return cv2.Laplacian(gray, cv2.CV_64F).var()


def detect_blur_image(image):
    gradient_magnitude = calculate_gradient_magnitude(image)
    blur_score = calculate_gaussian_blur(image)
    edge_percentage = calculate_canny_edge(image)
    pixel_distribution_percentage = calculate_pixel_distribution(image)
    smoothness_score = calculate_smoothness(image)
    combined_score = 100 * gradient_magnitude - 10 * blur_score + 100000000 * edge_percentage + pixel_distribution_percentage + 10 * smoothness_score
    return combined_score


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'files[]' not in request.files:
        return jsonify({'error': 'No files part'}), 400
    files = request.files.getlist('files[]')
    blur_images = []
    for file in files:
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)
            image = cv2.imread(filepath)
            if image is not None:
                combined_score = detect_blur_image(image)
                if combined_score < app.config['THRESHOLD']:
                    blur_images.append({'filename': filename, 'combined_score': combined_score})
            else:
                return jsonify({'error': f'Failed to read image: {filename}'}), 400
    return jsonify({'blur_images': blur_images}), 200


@app.route('/corrupted', methods=['GET'])
def detect_corrupted_images():
    corrupted_images = []
    for filename in os.listdir(app.config['UPLOAD_FOLDER']):
        try:
            img = cv2.imread(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            if img is None:
                corrupted_images.append(filename)
        except Exception as e:
            corrupted_images.append(filename)
    return jsonify({'corrupted_images': corrupted_images}), 200


@app.route('/')
def home():
    return 'Blur Image Detection'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
