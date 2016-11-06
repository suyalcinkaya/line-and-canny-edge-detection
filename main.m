%% Load  image
clc;
img = imread('input03.png');

%% Find edges
img = rgb2gray(img);
img_edges = edge(img, 'Canny');
imshow(img_edges);
title('Edges found in image');
saveas(gcf, 'output03_edges.jpg');

%% Perform Hough Transform for lines
[H, theta, rho] = hough_lines_acc(img_edges); 

%% Plot and save accumulator array H
figure();
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);
saveas(gcf, 'output03_accumulator.jpg');

%% Find Peaks
peaks = hough_peaks(H, 10); 

%% Highlight peak locations on accumulator array
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
title('Hough transform with peaks found');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(theta(peaks(:,2)),rho(peaks(:,1)),'o','LineWidth',3,'color','red');

%% Draw Lines
hough_lines_draw(img, peaks,rho,theta);
saveas(gcf, 'output03_lines.jpg');