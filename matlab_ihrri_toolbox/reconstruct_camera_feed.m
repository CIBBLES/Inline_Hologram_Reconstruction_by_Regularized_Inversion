clear all ;
close all ;
clc ;

% Make sure this is always false when commiting.
bDEBUG_LowRes = false;

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

% Available resolutions
%{'2592x1944'}   
%{'2048x1536'} 
%{'1920x1080'}  
%{'1600x1200'} 
%{'1280x960'}  
%{'1280x720'} 
%{'1024x768'}  
%{'800x600'}  
%{'640x480'}
%{'320x240'}

if bDEBUG_LowRes
    cam.Resolution = cam.AvailableResolutions{end};
else
    cam.Resolution = cam.AvailableResolutions{1};
end
resolution = str2double(extract(cam.Resolution, digitsPattern));

cam_fig = figure();
hImage = image(zeros(resolution(2), resolution(1), 3));
preview(cam, hImage)

data_fig = figure("Name", "Data");
phase_fig = figure("Name", "Phase");
opacity_fig = figure("Name", "Reconstructed Modulus");
residue_fig = figure("Name", "Residue");
figure(cam_fig);

run('parameters')

% reconstruction_script is now run by Holography_UI.
%run('reconstruction_script');
