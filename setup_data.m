% create videoReader object
reader = VideoReader('movie.mp4');
reader2 = VideoReader('movie_red.mp4');
% make a directory
mkdir images
foldername = "images";
for n = 1:382
    % read images
    if n <192
        I = reader.readFrame;
    else
        I = reader2.readFrame;
    end
    % resize images
    I = imresize(I,[227,227]);
    if n < 10
        filename = "image_" + "00"+n + ".bmp";
    elseif n < 100
        filename = "image_" + "0"+n + ".bmp" ;
    else
        filename = "image_"  +n + ".bmp" ;
    end
    % write image files
    filepath = fullfile(foldername,filename);
    imwrite(I,filepath);
end

% Copyright 2019 The MathWorks, Inc.