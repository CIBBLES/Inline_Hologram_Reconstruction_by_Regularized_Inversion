function cam_data = preprocess_data(cam_data)
% Preprocesses the data from the camera, to put it in the right format.
cam_data = rgb2gray(cam_data);
% cam_data = 1/3 * (cam_data(:,:,1) + cam_data(:,:,2) + cam_data(:,:,3));


% Resize data to square shape (an unfortunate consequence of a bug in the
% reconstruction formula which only allows it to work with squares.)
[old_y, old_x] = size(cam_data);
new_xbounds = [(old_x - old_y) / 2, (old_x + old_y) / 2 - 1];
cam_data = cam_data(:, new_xbounds(1):new_xbounds(2));
cam_data = double(cam_data) / double(median(cam_data(:)));
end