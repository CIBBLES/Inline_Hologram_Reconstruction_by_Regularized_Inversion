clear all ;
close all ;
clc ;

bLive_data = true;
cam = webcam("HY-500B");
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