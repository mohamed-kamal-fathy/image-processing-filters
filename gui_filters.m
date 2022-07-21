function varargout = gui_filters(varargin)
% GUI_FILTERS M-file for gui_filters.fig
%      GUI_FILTERS, by itself, creates a new GUI_FILTERS or raises the existing
%      singleton*.
%
%      H = GUI_FILTERS returns the handle to a new GUI_FILTERS or the handle to
%      the existing singleton*.
%
%      GUI_FILTERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FILTERS.M with the given input
%      arguments.
%
%      GUI_FILTERS('Property','Value',...) creates a new GUI_FILTERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_filters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_filters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_filters

% Last Modified by GUIDE v2.5 24-May-2022 04:33:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_filters_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_filters_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_filters is made visible.
function gui_filters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_filters (see VARARGIN)

% Choose default command line output for gui_filters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_filters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_filters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** load **********************%
                                  
                                  
% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File within Avilable Extensions');% ????????
image_path=[path file];% ???????
handles.file=image_path;
a = imread(image_path);% ????

axes(handles.axes_image0);
imshow(a);
setappdata(0,'a',a)
setappdata(0,'filename',a);
plot(handles.axes_image0,a)

                                    %****************************************
                                  %****************************************
                                  %****************************************
                                  %***************** gray *********************%


% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 oldImage=getappdata(0,'a');
 
[rows,cols,ch] = size(oldImage);
newImage = zeros(rows,cols,1);
for k = 1 : ch
    for x = 1 : rows
        for y = 1 : cols
        newImage(x,y,1) = 0.3 * oldImage(x,y,1) + 0.59 * oldImage(x,y,min(2,ch)) + 0.11 * oldImage(x,y,min(3,ch));
        end
    end    
end
newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage )

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** brightness **********************%
                                  
  
% --- Executes on button press in brightness.
function brightness_Callback(hObject, eventdata, handles)

oldImage=getappdata(0,'a');

[rows,cols,oldZ] = size(oldImage);
    brightedImage = zeros( rows , cols , oldZ , 'uint8' );
    for k = 1 : oldZ
        for i = 1 : rows
            for j = 1 : cols
                brightedImage(i,j,k) = oldImage(i,j,k) + 20;
                
                if(brightedImage(i,j,k) < 0)
                    brightedImage(i,j,k) = 0;
                end
                
                if(brightedImage(i,j,k)>255)
                    brightedImage(i,j,k) = 255;
                end
            end
        end
    end
    axes(handles.axes_image1); 
imshow(brightedImage )
 

% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                 %****************************************
                                  %****************************************
                                  %****************************************
                                  %*****************  constract *******************%

% --- Executes on button press in constract.
function constract_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

 [rows,cols,oldZ] = size(oldImage);
contrastedImage = zeros( rows , cols , oldZ , 'uint8' );
    
    oldMin = 0;
    oldMax = 255;
    
    for k = 1 : oldZ
        for i = 1 : rows
            for j = 1 : cols
                if(oldImage(i,j,k) < oldMin)
                    oldMin = oldImage(i,j,k);
                elseif(oldImage(i,j,k) > oldMax)
                    oldMax = oldImage(i,j,k);
                end
            end
        end
    end
newMax=160;
newMin=20;
    for k = 1 : oldZ
        for i = 1 : rows
            for j = 1 : cols
                contrastedImage(i,j,k) = double(double(oldImage(i,j,k) - oldMin) / double(oldMax-oldMin)) * double(newMax - newMin) + double(newMin) ;
                if(contrastedImage(i,j,k) < 0)
                    contrastedImage(i,j,k) = 0;
                end
                if(contrastedImage(i,j,k)>255)
                    contrastedImage(i,j,k) = 255;
                end
            end
        end
    end
    axes(handles.axes_image1); 
imshow(contrastedImage )
    
    
% hObject    handle to constract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                 %****************************************
                                  %****************************************
                                  %****************************************
                                  %*****************histogram *******************%


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');


[rows,cols,ch] = size(oldImage);
newImage = zeros(rows,cols,ch);
histogram = zeros(1,256);
for k = 1 : 256
    count = 0;
    for x = 1 : rows
        for y = 1 : cols
            if oldImage(x,y) == k-1
                count = count + 1;
            end
        end
    end
    histogram(1,k) = count;
end

bar(histogram)

 axes(handles.axes_image1); 
imshow(histogram )

% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** min **********************%
                                  
% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)

oldimage=getappdata(0,'a');

[old_rows, old_cols, dim] = size(oldimage);
maske = padarray(oldimage,[1 1],'replicate', 'both');
[new_rows, new_cols, dim] = size(maske);
newImage = zeros(old_rows, old_cols, dim);
for k = 1 : dim
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=sort([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =m(1);
            end
     end
end
newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %****************median  **********************%
                                  
% --- Executes on button press in median.
function median_Callback(hObject, eventdata, handles)
oldimage=getappdata(0,'a');

[old_rows, old_cols, dim] = size(oldimage);
maske = padarray(oldimage,[1 1],'replicate', 'both');
[new_rows, new_cols, dim] = size(maske);
newImage = zeros(old_rows, old_cols, dim);
for k = 1 : dim
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=sort([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =m(5);
            end
     end
end
newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** max********************%
                                
% --- Executes on button press in max.
function max_Callback(hObject, eventdata, handles)

oldimage=getappdata(0,'a');


[old_rows, old_cols, dim] = size(oldimage);
maske = padarray(oldimage,[1 1],'replicate', 'both');
[new_rows, new_cols, dim] = size(maske);
newImage = zeros(old_rows, old_cols, dim);
for k = 1 : dim
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=sort([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =m(9);
            end
     end
end
newImage = uint8(newImage);





axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** mean  *******************%
                                  
% --- Executes on button press in mean.
function mean_Callback(hObject, eventdata, handles)
oldimage=getappdata(0,'a');


[old_rows, old_cols, dim] = size(oldimage);
maske = padarray(oldimage,[1 1],'replicate', 'both');
[new_rows, new_cols, dim] = size(maske);
newImage = zeros(old_rows, old_cols, dim);
for k = 1 : dim
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=mean([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =m;
            end
     end
end
newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** mean-weighted *****%
                                 
% --- Executes on button press in mean_weighted.
function mean_weighted_Callback(hObject, eventdata, handles)

oldimage=getappdata(0,'a');


[old_rows, old_cols, dim] = size(oldimage);
maske = padarray(oldimage,[1 1],'replicate', 'both');
[new_rows, new_cols, dim] = size(maske);
newImage = zeros(old_rows, old_cols, dim);
for k = 1 : dim
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=mean([maske(x, y, k),maske(x, y, k),maske(x, y, k),maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =m;
            end
     end
end
newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage)





% hObject    handle to mean_weighted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** sharp *****%

% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
old_Image=getappdata(0,'a');


mask = padarray(old_Image,[1 1],'replicate', 'both');
[r, c, ch] = size(mask);
[r2, c2, ch2] = size(old_Image);
newImage = zeros(size(old_Image));
Sharpen_Mask=[-1,-1,-1,-1,9,-1,-1,-1,-1];

for k=1:ch
    for i=2:r-1
        for j=2:c-1
            z=1;
            sum=0;
            sum=double(sum);
            for x=i-1:i+1
                for y=j-1:j+1
                    sum=sum + double(mask(x,y,k)*Sharpen_Mask(z));
                    z=z+1;
                end
            end
            newImage(i-1,j-1,k) = sum;
        end
    end
end

for k=1:ch2
    for i=1:r2
        for j=1:c2
            
            if(newImage(i, j, k) > 255)
                newImage(i, j, k) = 255;
            end
            if(newImage(i, j, k) < 0)
                newImage(i, j, k) = 0;
            end
            
        end
    end
end

newImage = uint8(newImage);

axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** unsharping *****%

% --- Executes on button press in unsharp.
function unsharp_Callback(hObject, eventdata, handles)

old_Image=getappdata(0,'a');

 [old_rows, old_cols, dim] = size(old_Image);
    maske = padarray(old_Image,[1 1],'replicate', 'both');
    [new_rows, new_cols, dim] = size(maske);
    newImage1 = zeros(old_rows, old_cols, dim);
    for k = 1 : dim
         for x = 2 : new_rows-1
               for y = 2 : new_cols-1
                m=mean([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage1(x-1, y-1, k) =m;
               end
         end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %newImage1 from mean filter
  %  function newImage = Subtract_Images(old_Image, newImage1)
        [rows, cols, ch] = size(old_Image);
        image = imresize(newImage1, [rows, cols]);
        newImage2 = zeros(rows, cols, ch);
        for k = 1 : ch    
            for x = 1 : rows
                for y = 1 : cols
                    newImage2(x, y, k) = abs(old_Image(x, y, k) - image(x, y));
                    if(newImage2(x, y, k) > 255)
                        newImage2(x, y, k) = 255;
                    elseif(newImage2(x, y, k) < 0)
                        newImage2(x, y, k) = 0;
                    end
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %newImage2 from sub-images 
    %function newImage = Add_Images( image1 , image2)
    [rows, cols, oldZ] = size(old_Image);
    image = imresize(newImage2, [rows, cols]);
    newImage3 = zeros(rows, cols, oldZ ,'uint8');
    for k = 1 : oldZ  
        for i = 1 : rows
            for j = 1 : cols
                newImage3(i, j, k) = old_Image(i, j, k) + image(i, j); % to increase mask (highboost filtering) ,multiple mask in k which (( k>1))
                if(newImage3(i, j, k) > 255)
                    newImage3(i, j, k) = 255;
                elseif(newImage3(i, j, k) < 0)
                    newImage3(i, j, k) = 0;
                end
            end
        end
    end
     %newImage3 from add-images  
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sub_im = Sub_2Images(old_Image,newImage1);
%newImage = Add_2Images(old_Image,  newImage2);
   
newImage3 = uint8(newImage3);

axes(handles.axes_image1); 
imshow(newImage3)
% hObject    handle to unsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** edge *****%
% --- Executes on button press in edge_detection.
function edge_detection_Callback(hObject, eventdata, handles)
im=getappdata(0,'a');

im=rgb2gray(im);
[rr,cc,ch]=size(im);
N_im=padarray(im,[1 1],'replicate','both');
New_im=padarray(im,[1 1],'replicate','both');
%%%%%%%%%%%%%%%%%%              (Applying Equation)
r=2;    c=2;    summ=0;         
for k=1:ch
    for x=r:rr
            for y=c:cc
                %%%%%%%%%%%%%%%%%%%%%%%%
                    summ=((N_im(x+1,y,k)+N_im(x-1,y,k)+N_im(x,y+1,k)+N_im(x,y-1,k)) - 4*N_im(x,y,k) );
                    New_im(x,y,k)=round(summ);
            end
    end
end     
New_im= uint8(New_im);

axes(handles.axes_image1); 
imshow(New_im)
% hObject    handle to edge_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** butterw_lph *****%

% --- Executes on button press in butterw_lph.
function butterw_lph_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

D0 = 15;
n=1;
 [M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                newImage(u, v, k) = 1 / (1 + (D / D0)^(2 * n));
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);

axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to butterw_lph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** butterw_hpf. *****%
% --- Executes on button press in butterw_hpf.
function butterw_hpf_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');
D0 = 30;
n=2;
 [M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                newImage(u, v, k) = 1 / (1 + (D0 / D)^(2 * n));
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);

axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to butterw_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** gauss_lpf. *****%

% --- Executes on button press in gauss_lpf.
function gauss_lpf_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

D0 = 20;

[M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
    e = 2.7182818;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                newImage(u, v, k) = e ^-(D ^2 / (2 * D0^2));
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);


axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to gauss_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** gauss_hpf. *****%

% --- Executes on button press in gauss_hpf.
function gauss_hpf_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

D0 = 30;
[M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
    e = 2.7182818;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                newImage(u, v, k) = 1 - (e ^-(D ^2 / (2 * D0^2)));
            end
        end
    end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);

axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to gauss_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** ideal_lpf. *****%

% --- Executes on button press in ideal_lpf.
function ideal_lpf_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

D0 = 15;
[M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                if(D <= D0)
                   newImage(u, v, k) = 1;
                else 
                   newImage(u, v, k) = 0;
                end
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);

axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to ideal_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %****************  ideal_hpf. *****%
% --- Executes on button press in ideal_hpf.
function ideal_hpf_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');
 D0=30;
[M, N, K] = size(oldImage);
    newImage = zeros(M, N, K);
    FT = fft2(oldImage);
    FTS = fftshift(FT);
    Real = real(FTS);
    Imaginary = imag(FTS);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1 : K
        for u = 1 : M
            for v = 1 : N
                D =((u - M / 2)^2 + (v - N / 2)^2) ^0.5  ; 
                if(D <= D0)
                   newImage(u, v, k) = 0;
                else 
                   newImage(u, v, k) = 1;
                end
            end
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Real = Real .* newImage;
    Imaginary = Imaginary .* newImage;
    IFTS = ifftshift(Real + 1i * Imaginary);
    IFT = ifft2(IFTS);
    newImage=uint8(IFT);

axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to ideal_hpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** geomatric *****%
% --- Executes on button press in geomatric.
function geomatric_Callback(hObject, eventdata, handles)
im=getappdata(0,'a');

fact=3; 
[rr,cc,ch]=size(im);
noisy_image=imnoise(im,'gaussian');
N_im=padarray(noisy_image,[floor(fact/2) floor(fact/2)],'replicate','both');
%%%%%%%%%%%%%%%%%%
r=1;        c=1;        multi=1;
for k=1:ch
    for r=1:rr
       for c=1:cc
           
           for i=r:r+2
               for j=c:c+2
                   multi =  multi * double(N_im(i,j,k));
               end
           end
                    New_im(r,c,k)=nthroot(round(multi),9);
                    multi=1;
                    
        end
    end
   
end
New_im = uint8(New_im);

figure,imshow(noisy_image),title('Noisy Image  geometric')



axes(handles.axes_image1); 
imshow(New_im)  
  
%%%%%%%%%%%%%%%%%%%%%


% hObject    handle to geomatric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** midpoint *****%

% --- Executes on button press in midpoint.
function midpoint_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');

noisy_im=imnoise(oldImage,'salt & pepper');

[old_rows, old_cols, dim_shaban] = size(oldImage);
maske = padarray(noisy_im,[1 1],'replicate', 'both');
[new_rows, new_cols, dim_shaban] = size(maske);
newImage = zeros(old_rows, old_cols, dim_shaban);

for k = 1 : dim_shaban
     for x = 2 : new_rows-1
           for y = 2 : new_cols-1
                m=sort([maske(x, y, k),maske(x-1, y-1, k),maske(x-1, y, k),maske(x-1, y+1, k),maske(x, y-1, k),maske(x, y+1, k),maske(x+1, y-1, k),maske(x+1, y, k),maske(x+1, y+1, k)]);
                newImage(x-1, y-1, k) =mean([m(1),m(9)]);
            end
     end
end





%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%

newImage = uint8(newImage);
figure,imshow(noisy_im),title('adding noise')
axes(handles.axes_image1); 
imshow(newImage)

% hObject    handle to midpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                  %****************************************
                                  %****************************************
                                  %****************************************
                                  %**************** watermark. *****%

% --- Executes on button press in watermark.
function watermark_Callback(hObject, eventdata, handles)
im1=getappdata(0,'a');

[file, path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File within Avilable Extensions');% ????????
image_path=[path file];% ???????
handles.file=image_path;
W = imread(image_path);% ????


[r1,c1,ch1]=size(im1);
W=imresize(W,[r1 c1]);
for k=1:ch1
    for i=1:r1
        for j=1:c1
                he=bitget(im2(i,j,k),5:8);
                for bi=1:4
                    if he(bi)==1
                        im1(i,j,k)=bitset(im1(i,j,k),bi);
                    else
                        im1(i,j,k)=bitset(im1(i,j,k),bi,0);
                    end
                 end

        end
    end
end
    n=im1;
%%%%%%%%%%%%%%%%%  
figure,imshow(im1),title('Original Image')
figure,imshow(W),title('Watermark Image')
figure,imshow( n),title('Result')





%axes(handles.axes_image1); 
%imshow(Iw)
% hObject    handle to watermark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.

                                    %****************************************
                                  %****************************************
                                  %****************************************
                                  %****************** exit ********************%
                                  
% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
msgbox('                thanks for using image processing filters        ')
pause(2)
close();
close();
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                      %************************************
                                      %**** 
                                  %****************************************
                                  %****************************************
                                  %*******************power law*******************%


% --- Executes on button press in power_law.
function power_law_Callback(hObject, eventdata, handles)
oldImage=getappdata(0,'a');
oldMin = 0;
    oldMax = 255;
newMax=160;
newMin=20;
gamma=1.5;
[rows,cols,ch] = size(oldImage);
poweredImage = zeros(rows,cols,ch);
for k = 1 : ch
    for x = 1 : rows
        for y = 1 : cols
          value = double(oldImage(x,y,k)).^ double(gamma) ;
          contrastedImage= double(double(value - oldMin) / double(oldMax-oldMin)) * double(newMax - newMin) + double(newMin) ;
                if(contrastedImage< 0)
                    contrastedImage = 0;
                elseif(contrastedImage>255)
                    contrastedImage = 255;
                end  
               poweredImage(x,y,k)=contrastedImage;
        end
    end
end
poweredImage = uint8(poweredImage);


axes(handles.axes_image1); 
imshow(poweredImage)
% hObject    handle to power_law (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                      %****************************************
                                  %****************************************
                                  %****************************************
                                  %*******************zoom*******************%


% --- Executes on button press in zoom.
function zoom_Callback(hObject, eventdata, handles)
im=getappdata(0,'a');

fact=2;
[r,c,ch]=size(im);
new_r=r*fact;
new_c=c*fact;
New_im=zeros(new_r,new_c,ch);
for p=1:ch
    nr=1;
    for i=1:r
        nc=1;
        for j=1:c
            New_im(nr,nc,p)=im(i,j,p); 
            nc=nc+fact;
        end
            nr=nr+fact;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Filling Rows                       

for p=1:ch
    t=1;
    j=1;
    for i=1:new_r
        nc=1;   j=1;
        while(j<=c)
            check=1;    
             z=1;                    % iterator for the equation *i*
             col1=nc;            % for first value
             col2=nc+fact;  %for second value
             % check where to repeat last elemnt  
             if(j==c)
                 New_im(i,nc+1:new_c,p)=New_im(i,nc,p);
                 break;
             end
             %%%%%%%
             % check if minn index bigger than maxx index 
             if(col1>col2)     
                check=0;
             end
             %%%%%%%
             %%%%%%%% ( loop for the equation ) %%%%%%%%
            if(check)
                for k=col1+1:col2-1                % loop for filling      
                   New_im(i,k,p)=round(((New_im(i,col2,p) - New_im(i,col1,p))/fact)*z + New_im(i,col1,p));
                   z=z+1;
                end
            else
                for k=col2-1:-1:col1+1                % loop for filling      
                    New_im(i,k,p)=round(((New_im(i,col2,p) - New_im(i,col1,p))/fact)*z + New_im(i,col1,p));
                    z=z+1;
                end
            end
             %%%%%%%% ( End loop for the equation ) %%%%%%%% 
             nc=nc+fact;
            j=j+1;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               column                               %

for p=1:ch
    t=1;
    for i=1:new_c
        j=1;    nr=1;
        while (j<=r)
            check=1;    z=1;
            row1=nr;   %for first value 
            row2=nr+fact;   %for second value
            
            if(j==r)        % check 
                row2=new_r;
                New_im(nr+1:new_r,i,p)=New_im(nr,i,p);
                break;
            end
            %%%%%%%%
            % check
            if(row1>row2)
                check=0;
            end
            %%%% ( loop for the equation) %%%%
            if(check)  
                for k=row1+1:row2-1
                   New_im(k,i,p)= round(((New_im(row2,i,p) - New_im(row1,i,p))/fact)*z + New_im(nr,i,p));
                    z=z+1;
                end
                
            else    
                for k=row2-1:-1:row1+1
                    New_im(k,i,p)=round(((New_im(row2,i,p) - New_im(row1,i,p))/fact)*z + New_im(nr,i,p));
                    z=z+1;
                end
            end
            %%%% ( End loop for the equation) %%%%
            nr=nr+fact;
            j=j+1;
        end
    end
end

New_im = uint8(New_im);
%axes(handles.axes_image1); 
 figure,imshow(New_im)
% hObject    handle to zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                      %****************************************
                                  %****************************************
                                  %****************************************
                                  %*******************zoom*******************%


% --- Executes during object creation, after setting all properties.
function axes_image1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_image1

                                      %****************************************
                                  %****************************************
                                  %****************************************
                                  %*******************add*******************%


% --- Executes on button press in add_im.
function add_im_Callback(hObject, eventdata, handles)
image1=getappdata(0,'a');

[file, path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File within Avilable Extensions');% ????????
image_path=[path file];% ???????
handles.file=image_path;
image2 = imread(image_path);% ????

[rows, cols, oldZ] = size(image1);
    image = imresize(image2 , [rows, cols]);
    newImage = zeros(rows, cols, oldZ ,'uint8');
    for k = 1 : oldZ  
        for i = 1 : rows
            for j = 1 : cols
                newImage(i, j, k) = image1(i, j, k) + image(i, j);
                if(newImage(i, j, k) > 255)
                    newImage(i, j, k) = 255;
                elseif(newImage(i, j, k) < 0)
                    newImage(i, j, k) = 0;
                end
            end
        end
    end


axes(handles.axes_image1); 
imshow(newImage)
% hObject    handle to add_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

                                      %****************************************
                                  %****************************************
                                  %****************************************
                                  %*******************sub*******************%


% --- Executes on button press in sub_image.
function sub_image_Callback(hObject, eventdata, handles)

image1=getappdata(0,'a');

[file, path]=uigetfile({'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File within Avilable Extensions');% ????????
image_path=[path file];% ???????
handles.file=image_path;
image2 = imread(image_path);% ????

[rows, cols, ch] = size(image1);
    image = imresize(image2, [rows, cols]);
    newImage = zeros(rows, cols, ch);
    for k = 1 : ch    
        for x = 1 : rows
            for y = 1 : cols
                newImage(x, y, k) = abs(image1(x, y, k) - image(x, y));
                if(newImage(x, y, k) > 255)
                    newImage(x, y, k) = 255;
                elseif(newImage(x, y, k) < 0)
                    newImage(x, y, k) = 0;
                end
            end
        end
    end
    newImage = uint8(newImage);
    
   axes(handles.axes_image1); 
 imshow(newImage)
% hObject    handle to sub_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


                                      %****************************************
                                  %****************************************
                                  %****************************************
                                  %*************************************%

