function displayVideo(video)

figure;
while hasFrame(video)
    frame = readFrame(video);

    %display
    imshow(frame)
end
end

