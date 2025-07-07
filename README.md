STAGE 0: plot offset data and uncertainties in excel, as a function of along strike distance, per unit etc


STAGE 1:  If needed, determine the average offset pdf for each site if calculating multiple repeat offset calcs per profile
This can be done by averaging the mean of each run and propagating the standard deviation, or by adding the pdfs at each site


STAGE 2: Sum together displacement across multiple parallel strands if applicable 


STAGE 3: Sum together all offset data pdfs from all sites to make a COPD plot


FOR FIELD / DEM/ DEM MEASUREMENTS OF VERTICAL OFFSET DATA


FIRST: run the script plot_COPD_vertical_offset.m as is to see how the script runs with practice/ preloaded data (offset_data_matrix_test.mat)

SECOND: edit the matlab files to work for your data

1a) generate a spreadsheet in excel with the following information for each offset measurement site.  see field_offsets_data_example.xlsx as an example, or the matlab file of this data called offset_data_matrix.mat


Columns: 
1= site name/ number
2= average throw, dip slip, or vertical separation  
3= standard deviation of slip, 
4= distance along profile (the code doesn’t plot COPD as a function of distance yet but we may want to. its also a good way to track which site is which)
5 = unit offset at the site. must be numeric and not alphanumeric.  so you’ll need to come up with a scheme. 
6 = Quality Ranking. The code currently doesn’t use this ranking so for now its to keep track of data. If we do plot it the wasy I had my code set up was using a ranking scale of 1-3 where 3 = best and 1 = worst.  
7 = calculate the scaling factor based off of column 6 .  = Quality ranking/3 (so best = 1, worst = .3333) - not used in this version of the code, so can be left blank

Rows: 
data for each offset site



2) open or duplicate the matlab data matrix called offset_data_matrix_blank.mat in matlab by double clikcing on the file in the matlab workspace, or by typing 
	load('offset_data_matrix_blank')  

in the command window.  it should load a blank variable called offset_data_matrix.
Open the offset_data_matrix variable and copy=paste all the data in the excel table rows.


3) generate a header cell array file in matlab that has the labels for the data above. you can copy the existing header file offset_data_matrix_headers.mat or open it and edit it or make your own (open the header variable, and enter in each cell 1 thru 7, the text in the headers in your excel data sheet)


4) save these two variables with the matlab command:  

		save('offset_data_headers_NAME’, 'headers’)

		save('offset_data_matrix_NAME’, ‘data’)


where ‘offset_data_NAME is the file name you will save your data as, and the other two are the variables you will save



5) To run the matlab script called plot_COPD_vertical_offset_AA.m  for your data, first you will need to edit the script (maybe make a copy/backup?)

THINGS YOU NEED TO EDIT IN THE SCRIPT

a) Lines 44-45  make sure you edit the matlab data file name  to be equal to the filename you just saved in the step 4 above

b) Lines 82-100  (secrtion %%  SORT PDFS BY UNIT THAT IS OFFSET %%) - Duplicate the blocks of code for plotting COPD for each unit depending on how many units you have

c) Lines 106 - 150 - Duplicate the blocks of code for any additional units to make the temp plots of COPD per unit to check if they are correct  (optional, you may not use these anyway)

d) Lines 168 to 182 - duplicate lines of code to plot additional units on the final plot (secition %% PLot Total COPD & individual unit COPSS overlain on the same figure %%)

e) lines 189-190 - edit output filenames


The script should run and generates 4 plots 
1 -  a plot of all the individual site PDFs and a summed COPD for all the data, 
2-4 Temporary plots to check if the division of COPDs by unit is working correctly
5 - the Final COPD for all sites with COPD for each unit overlain on the same plot


The code will auto save your data and a figure. you can comment this out if you don’t want to auto save (% = comment in matlab)


