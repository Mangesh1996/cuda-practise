import cv2
import numpy as np

image=cv2.imread("/home/magnesh/Documents/workspace/c++_workspace/cuda_leaning/sample-images-main/image-1.jpg")

gray_img=(
    0.1140*image[:,:,0]
    +0.5878*image[:,:,1]
    +0.2989*image[:,:,2]
    ).astype(np.uint8)
# gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

cv2.imshow("graysacl image ",gray_img)
cv2.waitKey(0)
cv2.destroyAllWindows()