function lab_09()
    I=double(imread('bimage2.bmp')) / 255;

    figure;
    imshow(I); 
    title('Исходное изображение');

    PSF=fspecial('motion', 55, 205);
    [J1 P1]=deconvblind(I, PSF);
    figure;
    imshow(J1);
    title('Восстановленное изображение'); 
end