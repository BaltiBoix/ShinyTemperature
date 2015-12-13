
This is an interactive application that shows historical temperatures for spanish meteorological stations.  

The data is read from the ftp service of NOAA (USA) and saved in ```TData.rda```. In *global.R* this file is 
loaded into a Data Frame. All the code used to generate this file can be found in my github repository:

      https://github.com/BaltiBoix/ghcn.git
      https://baltiboix.github.io/ghcn/ghcn.html

The mode of use is simple: choose an station and a year an automatically the data from the database is shown as
plots:

      - A daily plot of maximum and minimum Temperatures (TMAX ans TMIN)
      - A box plot of monthly data.
      
The data is also shown in a table where you choose between TMAX ans TMIN:

      - Monthly average temperatures in °C x 10
      - Monthly standard deviation temperatures in °C x 10
