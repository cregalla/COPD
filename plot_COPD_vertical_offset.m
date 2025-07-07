%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Generate a COPD of vertical slip (throw) or vertical separation measured from topographic profiles across fault scarps %%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  INPUTS: 
%
%  A) A .mat numeric matrix with columns for
%       1 - Site Numer
%       2 - average slip or vertical separation
%       3 - standard deviation of slip or vertical separation
%       4 - distance along strike
%       5 - unit number (but be numbers only, no text)
%       6 - Quality Ranking, if applicable (3 = best, 1 = worst) *
%       7 - Scaling factor (Quality ranking / 3), if applicable *
%
%       EXAMPLE INPUT FILE NAME = offset_data_matrix.mat
%
% * This code currenlty does not accout for quality scalinf
%   
%  B) A .mat Header text file  
%
%       EXAMPLE INPUT FILE NAME = offset_data_matrix_headers.mat
%
% This code will generate an offset pdf for a single site assuming a 
% Gaussian distribution based on the mean and stdev for each site. 
% Then it will sum the PDFS to make a COPD
%
% OUTPUTS: 
%  A .mat file called COPD_Data.mat with COPDF data for Total and
%     per unit COPD calculations
%  A figure of COPDF data for Total and
%     per unit COPD calculations called TOTAL_AND_PER_UNIT_COPD.fig
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all  % clear all variable and close all plots


%%%%%% !!! EDIT INPUT FILE NAME HERE !!!! %%%%%%%

    data = importdata('offset_data_matrix_test.mat'); % enter data filename here, this is a matrix
    headers = importdata('offset_data_headers.mat'); % enter header filename here, this is a cell array

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Read Data
n = size(data,1); % read the data matrix to determine the number of rows (measurement sites)
x=[0:.01:10];  % set the discretization interval (delta x) for calculating pdfs
PDF_all = zeros(n,length(x));


% Generate pdf for eachsite
for i = 1:n
pdf = normpdf(x, data(i,2), data(i,3)); % calculate a normal pdf assuming the 1 sigma value 
pdf = pdf./(max(pdf));%normalize the pdf values so that max = 1
PDF_all(i,:) = pdf; % tabulate all data into a single matrix
end


% Calculate COPD 
CPDF = nansum(PDF_all, 1);  % add all pdfs together


% Plot all individual site pdfs and the cumulative sum pdf 
%   --> use this to double check that the data look correct
    figure; subplot(2,1,1); set(gcf, 'Name', 'TEMP - check if individual PDF and COPD look right')  % make figure and define settings
    plot(x,PDF_all, '-k'); xlabel 'Vertical offset (m)'; ylabel 'Likilood'; title 'PDF for each site';
    xlim([0,2])
    subplot(2,1,2)
    plot(x,CPDF, '-k'); xlabel 'Vettical offset (m)'; ylabel 'Cumulative Likilood'; title 'Cumulative PDF';
    xlim([0,2])
    %title ('TEMP - check if individual PDF and COPD look right'

%%  SORT PDFS BY UNIT THAT IS OFFSET %%
%


% Find all dat for Unit 1
[I1,J1] = find(data(:,5)==1); % Find all the pdf data for sites in this unit
UNIT1_PDF_ALL = PDF_all(I1,:); % make a matrix of pdfs for just this unit
COPD_SUM_ALL_UNIT1 = sum(UNIT1_PDF_ALL, 1); % sum pdfs to get COPD for this unit
 n1 = length(I1); % count of how many site in this unit
  
% Find all dat for Unit 2
[I2,J2] = find(data(:,5)==2); % Find all the pdf data for sites in this unit
UNIT2_PDF_ALL = PDF_all(I2,:); % make a matrix of pdfs for just this unit
COPD_SUM_ALL_UNIT2 = sum(UNIT2_PDF_ALL, 1);  % sum pdfs to get COPD for this unit
 n2 = length(I2); % count of how many site in this unit

% Find all dat for Unit 3
[I3,J3] = find(data(:,5)==3); % Find all the pdf data for sites in this unit
UNIT3_PDF_ALL = PDF_all(I3,:); % make a matrix of pdfs for just this unit
COPD_SUM_ALL_UNIT3 = sum(UNIT3_PDF_ALL, 1);  % sum pdfs to get COPD for this unit
 n3 = length(I3); % count of how many site in this unit

 %%% COPY PASTE THE CODE FOR UNIT 3 AND ITERATE FOR ADDITIONAL UNITS AS NEEDED %%%


% Make some placeholder figs 
% Unit 1 offsets - plot to see if it looks correct

figure; hold on; set(gcf, 'Name', 'TEMP - check if Unit PDFS and COPD look right')  % make figure and define settings

    subplot (2,1,1)
     plot (x, UNIT1_PDF_ALL, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 1 sites'; ylabel 'Cumulative Likelihood'
      text(1, max(COPD_SUM_ALL_UNIT1)*.75, ['N = ', num2str(n1)]);

    subplot (2,1,2)
     plot (x, COPD_SUM_ALL_UNIT1, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 1 sites'; ylabel 'Cumulative Likelihood'
      text(1, max(COPD_SUM_ALL_UNIT1)*.75, ['N = ', num2str(n1)]);
      

% Unit 2 offsets - plot to see if it looks correct
figure; hold on; set(gcf, 'Name', 'TEMP - check if Unit PDFS and COPD look right')  % make figure and define settings

    subplot (2,1,1)
     plot(x, UNIT2_PDF_ALL, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 2 sites'; ylabel 'Cumulative Likelihood'
      text(1, max(COPD_SUM_ALL_UNIT2)*.75, ['N = ', num2str(n2)]);


    subplot (2,1,2)
     plot (x, COPD_SUM_ALL_UNIT2, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 2 sites'; ylabel 'Cumulative Likelihood'
      text(1, max(COPD_SUM_ALL_UNIT2)*.75, ['N = ', num2str(n2)]);
      

      
% Unit 3 offsets - plot to see if it looks correct
figure; hold on; set(gcf, 'Name', 'TEMP - check if Unit PDFS and COPD look right')  % make figure and define settings

    subplot (2,1,1)
     plot (x, UNIT3_PDF_ALL, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 3 sites'; ylabel 'Cumulative Likelihood'
      text(1, max(COPD_SUM_ALL_UNIT3)*.75, ['N = ', num2str(n3)]);


    subplot (2,1,2)
     plot (x,  COPD_SUM_ALL_UNIT3, '-k'); xlim([0,2]);
      xlabel 'Vertical Offset (m), Unit 3 sites'; ylabel 'Cumulative Likelihood'
      text(1, max( COPD_SUM_ALL_UNIT3)*.75, ['N = ', num2str(n3)]);


%%% COPY PASTE THE CODE FOR UNIT 3 AND ITERATE FOR ADDITIONAL UNITS AS NEEDED %%%



%% PLot Total COPD & individual unit COPSS overlain on the same figure %%
%          one plot to rule them all....



% All Data 
    figure; hold on; set(gcf, 'Name', 'Final Plot - USE ME'); % make figure and define settings
    subplot (2,1,2); hold on; 
     p(1) = plot (x, CPDF, '-k', 'LineWidth', 2); xlim([0,2]);
     xlabel 'Vertical offset (m)'; ylabel 'Cumulative Likelihood'
     title ('All COPD and Per Unit COPD')
            
     %%%%%%%%%%%%%%%%%%%%%%%%%%%
              
     % UNIT 1
      p(2) = plot (x, COPD_SUM_ALL_UNIT1, '-r'); xlim([0,2]);
      xlabel ' Horizontal offset (m) for all Ash Hill sites, Unit1 '; ylabel 'Cumulative Likelihood'

     % UNIT 2
      p(3) = plot (x, COPD_SUM_ALL_UNIT2,'-b'); xlim([0,2]);
      xlabel ' Horizontal offset (m) for all Ash Hill sites, Unit2 '; ylabel 'Cumulative Likelihood'
   
     % UNIT 3
      p(4) = plot (x, COPD_SUM_ALL_UNIT3, '-g'); xlim([0,2]);
      xlabel ' Horizontal offset (m) for all Ash Hill sites, Unit3 '; ylabel 'Cumulative Likelihood'

       %%% COPY PASTE THE CODE FOR UNIT 3 AND ITERATE FOR ADDITIONAL UNITS AS NEEDED %%%
    
     legend(p, 'All Data', 'Unit1', 'Unit2', 'Unit3')
     %%%%%%%%%%%%%%%%%%%%%%%%%%%    
  

     % clear temporary variables
     clear i I1 Ji I2 J2 I3 J3 n p pdf 

save('COPD_Data_NAME')  % save workspace change NAME to be the name of your data file
saveas(gcf,['COPD_plots_NAME.fig']) %save figure change NAME to be the name of your data file

%}