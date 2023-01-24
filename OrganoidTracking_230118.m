%% Organoid Tracking | Written by JJC
clc
clear all
close all

%% Load videos
% Locate all .mp4 videos in the same folder as this script
mp4_files = dir('*.mp4');
filenames = {mp4_files.name};

%% Image Analysis
% Each video will be filtered and analyzed in this loop
for i = 1:1:length(filenames)
    
    % Separate video into individual frames
    video_name = filenames{i};
    video = VideoReader(video_name);
    y=0;
    frameSet=[];
    
    while hasFrame(video)
        y=y+1;
        frame=readFrame(video);
        frame=rgb2gray(frame);
        frameSet=[frameSet, {frame}]; % Creates a cell array with all the frames of the video in it.
    end
    
    % Apply filter to all other frames in video
    for j = 1:1:length(frameSet)
        figure
        subplot(1,3,1)
        imshow(frameSet{j});
        img = frameSet{j};
        img = imadjust(img);
        subplot(1,3,2)
        imshow(img);
        BW = imbinarize(img,.9);
        BW = bwareafilt(BW,3);
        subplot(1,3,3)
        imshow(BW);
        a = 1+1
        % Look at imopen, imclose, https://www.mathworks.com/help/images/boundary-tracing-in-images.html
    end
    

end

% %% Save Outputs
% outputfile=['IntensityOutput_',datestr(now, 'dd-mmm-yyyy')];
% save(outputfile,'filenames','avg_pixel_intensity','background_intensity','num_frames')