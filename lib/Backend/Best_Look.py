import cv2
import numpy as np
from skimage.metrics import structural_similarity as ssim
from collections import defaultdict
import os
import random
import concurrent.futures

# Define constants
No_of_test_samples = 10
No_of_best_looking_samples = 60
ssim_threshold = 12.5
symmetry_threshold = 0.55
color_variation_threshold = 80
blur_threshold = 2000000


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
device_folder = 'Test_Data'
device_images = os.listdir(device_folder)
device_images = random.sample(device_images, k=No_of_test_samples)

# Initialize dictionary to store SSIM scores for each device photo
device_scores = defaultdict(float)

# Initialize list to store symmetry scores for each device photo
symmetry_scores = []

# Initialize dictionary to store color variation scores for each device photo
color_variation_scores = {}


# Function to process each device photo
def process_photo(photo):
    device_image = cv2.imread(os.path.join(device_folder, photo), cv2.IMREAD_GRAYSCALE)

    # Calculate blur score
    gradient_magnitude = cv2.Laplacian(device_image, cv2.CV_64F).var()

    # Reject further analysis if the image is blurry
    if gradient_magnitude >= blur_threshold:

        return

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
    lab_image = cv2.cvtColor(cv2.imread(os.path.join(device_folder, photo)), cv2.COLOR_BGR2LAB)
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
