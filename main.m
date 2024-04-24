clear all; close all; clc;

%% initial video
video = VideoReader("video.MOV");



%% Find the cell F
%cell_F = findF(video);

nombre_frames = video.NumFrames;
cell_F = cell(1,nombre_frames-1);
cell_F_stabilized = cell(1,nombre_frames-1);
cell_C = cell(1,nombre_frames-1);
cell_B = cell(1,nombre_frames-1);
cell_P = cell(1,nombre_frames-1);
cell_frame = cell(1,nombre_frames);

coeff_frame_reduction = 1/10;

%F1 is defined as I1, the algorythm begins at i = 2

cell_frame{1} = readFrame(video);
cell_frame{1} = im2gray(cell_frame{1});
cell_frame{1} = im2double(cell_frame{1}(round(size(cell_frame{1},1)*coeff_frame_reduction):end-round(size(cell_frame{1},1)*coeff_frame_reduction),round(size(cell_frame{1},2)*coeff_frame_reduction):end-round(size(cell_frame{1},2)*coeff_frame_reduction),1));
%cell_frame{1} = im2double(cell_frame{1});
cell_F{1} = eye(size(cell_frame{1},2));
cell_F_stabilized{1} = cell_F{1};
cell_C{1} = cell_F{1};
cell_B{1} = inv(cell_C{1});
cell_P{1} = cell_F{1};
i = 2;

while hasFrame(video)
    
    cell_frame{i} = readFrame(video);
    cell_frame{i} = im2gray(cell_frame{i});
    cell_frame{i} = im2double(cell_frame{i}(round(size(cell_frame{i},1)*coeff_frame_reduction):end-round(size(cell_frame{i},1)*coeff_frame_reduction),round(size(cell_frame{i},2)*coeff_frame_reduction):end-round(size(cell_frame{i},2)*coeff_frame_reduction),1));
    %cell_frame{i} = im2double(cell_frame{i});

    cell_F{i} = cell_frame{i-1}\cell_frame{i};
    
    original_frame = cell_frame{i-1}*cell_F{i};
    imshow(original_frame)

    cell_C{i} = cell_C{i-1}*cell_F{i};
 
    cell_B{i} = cell_F{i}\cell_B{i-1};

    cell_P{i} = cell_C{i}*cell_B{i};

    cell_F_stabilized{i} = cell_P{i-1}\cell_P{i};

    %stabilized_frame = cell_frame{i-1}*cell_F_stabilized{i}(size(cell_frame{i-1},2),size(cell_frame{i-1},2));
    %imshow(stabilized_frame)
    
    
    i = i+1
end


