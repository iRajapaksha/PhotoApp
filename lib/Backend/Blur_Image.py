import os
import cv2
import numpy as np


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


def calculate_smoothness(image):
    # Convert the image to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Calculate the variance of the Laplacian
    laplacian_var = cv2.Laplacian(gray, cv2.CV_64F).var()

    return laplacian_var


def detect_blur_images(folder_path, threshold):
    blur_images = []

    # Iterate over each image in the folder
    for filename in os.listdir(folder_path):
        # Check if the file is a JPEG or PNG image
        if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.jfif', '.webp')):
            image_path = os.path.join(folder_path, filename)

            # Read the image
            image = cv2.imread(image_path)

            # Check if the image is loaded successfully
            if image is not None:
                # Calculate gradient magnitude
                gradient_magnitude = calculate_gradient_magnitude(image)

                # Calculate Gaussian blur score
                blur_score = calculate_gaussian_blur(image)

                # Calculate Canny edge score
                edge_percentage = calculate_canny_edge(image)

                # Calculate pixel distribution percentage
                pixel_distribution_percentage = calculate_pixel_distribution(image)

                # Calculate smoothness score
                smoothness_score = calculate_smoothness(image)

                # Combine scores (you can adjust weights based on importance)
                combined_score = 100 * gradient_magnitude - 10 * blur_score + 100000000 * edge_percentage + pixel_distribution_percentage + 10 * smoothness_score

                # Check if combined score is below threshold
                if combined_score < threshold:
                    blur_images.append((filename, combined_score))
            else:
                print(f"Failed to read image: {filename}")

    return blur_images


def detect_corrupted_images(directory):
    corrupted_images = []
    for filename in os.listdir(directory):
        try:
            img = cv2.imread(os.path.join(directory, filename))
            if img is None:
                corrupted_images.append(filename)
        except Exception as e:
            print(f"Error reading {filename}: {e}")
            corrupted_images.append(filename)
    return corrupted_images


# Example usage:
folder_path = "Test_Data"
threshold = 4000000  # Adjust this threshold as needed

blur_images = detect_blur_images(folder_path, threshold)

if blur_images:
    print("Blurry images:")
    for image, combined_score in blur_images:
        print(f"{image}: Combined Score: {combined_score}")
else:
    print("No blurry images found.")


print("\n")

corrupted_images = detect_corrupted_images(folder_path)
print("Corrupted images:", corrupted_images)
