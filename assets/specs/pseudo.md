## decrement item quantity upon checkout
- both cart item and upload have sellerId field
- sellerId will be used to search for cart item in [uploads] collection 
- once found, update the quantity field of the upload item by decrementing
