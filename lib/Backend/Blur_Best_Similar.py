import cv2
import os
import numpy as np
from skimage.metrics import structural_similarity as ssim
from collections import defaultdict
import random
import concurrent.futures

# Define constants
No_of_test_samples = 5
No_of_best_looking_samples = 60
ssim_threshold = 9.5
symmetry_threshold = 0.45
color_variation_threshold = 60


def calculate_gradient_magnitude(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Compute gradients in x and y directions
    grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=3)
    grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=3)

    # Compute gradient magnitude
    gradient_magnitude = cv2.magnitude(grad_x, grad_y)

    # Calculate the mean of gradient magnitude
    mean_gradient_magnitude = cv2.mean(gradient_magnitude)[0]

    return mean_gradient_magnitude


def calculate_gaussian_blur(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Compute Gaussian blur score
    blur_score = cv2.Laplacian(gray, cv2.CV_64F).var()

    return blur_score


def calculate_canny_edge(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Compute Canny edges
    edges = cv2.Canny(gray, 50, 150)

    # Calculate the percentage of edge pixels
    edge_percentage = cv2.mean(edges)[0] / 255

    return edge_percentage


def calculate_pixel_distribution(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Calculate histogram of pixel intensity values
    hist = cv2.calcHist([gray], [0], None, [256], [0, 256])

    # Calculate the percentage of pixels in the histogram with non-zero intensity values
    non_zero_percentage = np.sum(hist[1:]) / np.sum(hist)

    return non_zero_percentage


def detect_blur_images(folder_path, threshold):
    blur_images = []

    # Iterate over each image in the folder
    for filename in os.listdir(folder_path):
        image_path = os.path.join(folder_path, filename)

        # Read the image
        image = cv2.imread(image_path)

        # Calculate gradient magnitude
        gradient_magnitude = calculate_gradient_magnitude(image)

        # Calculate Gaussian blur score
        blur_score = calculate_gaussian_blur(image)

        # Calculate Canny edge score
        edge_percentage = calculate_canny_edge(image)

        # Calculate pixel distribution percentage
        pixel_distribution_percentage = calculate_pixel_distribution(image)

        # Combine scores (you can adjust weights based on importance)
        combined_score = gradient_magnitude + 0.1*blur_score + 0.01*edge_percentage + 0.001*pixel_distribution_percentage

        # Check if combined score is below threshold
        if combined_score < threshold:
            # blur_images.append((filename, combined_score))
            blur_images.append(filename)

    return blur_images


folder_path = "Test_Data"
threshold = 25  # Adjust this threshold as needed

blur_images = detect_blur_images(folder_path, threshold)

if blur_images:
    print("Blurry images:")
    # for image, combined_score in blur_images:
    #     print(f"{image}: Combined Score: {combined_score}")
    for image in blur_images:
        print(f"{image} is blurry.")

else:
    print("No blurry images found.")

# -------------------------------------------------------------------------------------------------------------------------------------
# Function to resize images to a specified size
def resize_image(image, size):
    return cv2.resize(image, size, interpolation=cv2.INTER_AREA)


# Load reference images and resize them
reference_folder = 'Best_Looking_Samples'
reference_images = os.listdir(reference_folder)
reference_images = random.sample(reference_images, k=No_of_best_looking_samples)

resized_reference_images = {}
reference_grayscale_images = {}
for ref_image in reference_images:
    reference_image = cv2.imread(os.path.join(reference_folder, ref_image), cv2.IMREAD_GRAYSCALE)
    ref_height, ref_width = reference_image.shape[:2]
    resized_reference_images[ref_image] = resize_image(reference_image, (ref_width // 2, ref_height // 2))
    reference_grayscale_images[ref_image] = reference_image

# Load device photos
device_images = os.listdir(folder_path)
device_images = random.sample(device_images, k=No_of_test_samples)

# Initialize dictionary to store SSIM scores for each device photo
device_scores = defaultdict(float)

# Initialize list to store symmetry scores for each device photo
symmetry_scores = []

# Initialize dictionary to store color variation scores for each device photo
color_variation_scores = {}


# Function to process each device photo
def process_photo(photo):
    device_image = cv2.imread(os.path.join(folder_path, photo), cv2.IMREAD_GRAYSCALE)

    # Calculate SSIM score
    for ref_image, reference_image in reference_grayscale_images.items():
        resized_reference_image = resized_reference_images[ref_image]
        score = ssim(resized_reference_image, resize_image(device_image, resized_reference_image.shape[::-1]))
        device_scores[photo] += score

    # Calculate symmetry score
    flipped = cv2.flip(device_image, 1)
    symmetry = ssim(device_image, flipped)
    symmetry_scores.append((photo, symmetry))

    # Calculate color variation score
    lab_image = cv2.cvtColor(cv2.imread(os.path.join(folder_path, photo)), cv2.COLOR_BGR2LAB)
    std_dev = np.std(lab_image, axis=(0, 1))
    color_variation_scores[photo] = np.sum(std_dev)


# Process device photos concurrently
with concurrent.futures.ThreadPoolExecutor() as executor:
    executor.map(process_photo, device_images)

# Rank the device photos based on the sum of SSIM scores
ranked_device_photos = sorted(device_scores.items(), key=lambda x: x[1], reverse=True)

# Rank the symmetric photos based on the symmetry scores
ranked_symmetry_device_photos = sorted(symmetry_scores, key=lambda x: x[1], reverse=True)

# List to store images surpassing all thresholds
images_surpassing_thresholds = []

# Iterate through the ranked list of device photos
for photo, score_sum in ranked_device_photos:
    # Find the corresponding symmetry score and color variation score
    symmetry = next((symmetry for photo_symmetry, symmetry in ranked_symmetry_device_photos if photo_symmetry == photo),
                    0)
    variation_score = color_variation_scores.get(photo, 0)

    # Check if all thresholds are surpassed and the image is not blurry
    if (score_sum > ssim_threshold and
            symmetry > symmetry_threshold and
            variation_score > color_variation_threshold):
        images_surpassing_thresholds.append(photo)

print('Images surpassing all thresholds:', images_surpassing_thresholds)
print('\n')
best_not_blur = [image for image in images_surpassing_thresholds if image not in blur_images]
print('Images surpassing all thresholds and not blur:', best_not_blur)

