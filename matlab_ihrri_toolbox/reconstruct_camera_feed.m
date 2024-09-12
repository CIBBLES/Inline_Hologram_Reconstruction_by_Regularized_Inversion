clear all ;
close all ;
clc ;

bLive_data = true;
try
    cam = webcam("HY-500B");
catch e
     if strcmp(e.identifier,'MATLAB:webcam:invalidName')
         warning("Hayeur camera not found. Using default camera.")
         cam = webcam(1);
     else
         rethrow(e);
     end
end
cam.Resolution = cam.AvailableResolutions{end};
resolution = str2double(extract(cam.Resolution, digitsPattern));

cam_fig = figure();
hImage = image(zeros(resolution(2), resolution(1), 3));
preview(cam, hImage)

phase_fig = figure();
opacity_fig = figure();
residue_fig = figure();
figure(cam_fig);

run('reconstruction_script');

% We only appear to receive video frames after the code has finished
% reconstructing an image.