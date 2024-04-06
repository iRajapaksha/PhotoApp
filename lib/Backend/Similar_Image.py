import os
import cv2
from skimage.metrics import structural_similarity as ssim
from keras.applications import ResNet50
from keras.applications.resnet50 import preprocess_input
from keras.models import Model
from keras.layers import GlobalAveragePooling2D


def load_images_from_directory(directory, blur_threshold):
    image_files = os.listdir(directory)
    images = []
    non_blur_image_files = []
    for image_file in image_files:
        image_path = os.path.join(directory, image_file)

        # Read the image
        image = cv2.imread(image_path)

        # Detect blur
        if not is_blurred(image, blur_threshold):
            images.append(image)
            non_blur_image_files.append(image_file)

    return non_blur_image_files, images


def is_blurred(image, threshold):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Compute gradients in x and y directions
    grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=3)
    grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=3)

    # Compute gradient magnitude
    gradient_magnitude = cv2.magnitude(grad_x, grad_y)

    # Compute variance of gradient magnitude
    variance = cv2.meanStdDev(gradient_magnitude)[1] ** 2

    # Check if variance is below threshold
    return variance < threshold


def extract_resnet50_features(images):
    base_model = ResNet50(weights='imagenet', include_top=False)
    model = Model(inputs=base_model.input, outputs=GlobalAveragePooling2D()(base_model.output))
    feature_vectors = [model.predict(preprocess_input(cv2.resize(image, (224, 224))).reshape(1, 224, 224, 3)).flatten()
                       for image in images]
    return feature_vectors


def calculate_similarity(image1, image2):
    gray1 = cv2.cvtColor(cv2.resize(image1, (120, 120)), cv2.COLOR_BGR2GRAY)
    gray2 = cv2.cvtColor(cv2.resize(image2, (120, 120)), cv2.COLOR_BGR2GRAY)
    return ssim(gray1, gray2)


image_dir = "Test_Data"
blur_threshold = 2600  # Adjust this threshold as needed
image_files, images = load_images_from_directory(image_dir, blur_threshold)
feature_vectors = extract_resnet50_features(images)

similar_image_list_for_further_analysis = []

for i, ref_image in enumerate(images):
    for j, comp_image in enumerate(images[i + 1:], start=i + 1):
        similarity_score = calculate_similarity(ref_image, comp_image)
        if similarity_score > 0.18:  # Adjust the threshold as needed
            # Check if the pair already exists
            pair = (image_files[i], image_files[j])
            if pair not in similar_image_list_for_further_analysis:
                similar_image_list_for_further_analysis.extend(pair)

# Now similar_image_list_for_further_analysis contains image1 and image2 as separate elements
# Convert the list to a set to remove duplicates, then back to a list
similar_image_list_for_further_analysis = list(set(similar_image_list_for_further_analysis))

print(similar_image_list_for_further_analysis)

# Iterate through similar_image_list_for_further_analysis and find similar images
for image in similar_image_list_for_further_analysis:
    # print(f"Similar images for {image}:")

    # Create a list to store similar images for the current image
    similar_images = []

    # Compare the current image with every other image in the list
    for other_image in similar_image_list_for_further_analysis:
        if other_image != image:
            similarity_score = calculate_similarity(cv2.imread(os.path.join(image_dir, image)),
                                                    cv2.imread(os.path.join(image_dir, other_image)))
            # Check if the SSIM score exceeds the threshold
            if similarity_score > 0.30:
                similar_images.append(other_image)
                similar_image_list_for_further_analysis.remove(other_image)

    # Print out similar images for the current image
    if similar_images:
        print(f"Similar images for {image} are: {', '.join(similar_images)}")
        similar_image_list_for_further_analysis.remove(image)
