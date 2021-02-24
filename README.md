# Chicago Dataset: Basic Data Frame Manipulation Using "dplyr" Package 

## Description
Daily air pollution and temperature data for Chicago

## Packages Installed
**dplyr** is a grammar of data manipulation providing a consistent set of verbs that help you solve the most common data manipulation challenges. These are combined naturally with `group_by()` which allows you to perform any operation "by group".

    install.packages("dplyr")

After installing the **dplyr** package, you must call its library.

    library("dplyr")
    
## Accessing the Chicago File
We can access the file through this link. Note that the data file is a `zip` file.

(http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip)

### Downloading and Unzipping the file directly from the web to R console
To download the file directly in R console use the codes below.

    download.file("http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip",destfile="chicago.zip")

After downloading the zip file we must unzip it. In unzipping a file you must open a connection to the zip archive and the file inside it using the function `unz()`

    con = unz("chicago.zip", filename = "chicago.rds")
 
 Apply `gzip` decompression to the connection using `gzcon()` function. This function provides a modified connection that wraps an existing connection and decompresses reads or compressess writes through that connection.
 
    con2 = gzcon(con)
 
To read the connection we must use the `readRDS()` function. We will store the data inside the variable **chicago**

    chicago = readRDS(con2)
    
Then we must close the connection.

    close(con2)
    
## Manipulating the Chicago Dataset  
    

A. To view the basic characteristics of the dataset we can use `dim()` and `str()` functions.

    dim(chicago)
    [1] 6940    8
    

    
    str(chicago)
    'data.frame':   6940 obs. of  8 variables:
    $ city      : chr  "chic" "chic" "chic" "chic" ...
    $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
    $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
     $ date      : Date, format: "1987-01-01" "1987-01-02" ...
     $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
    $ pm10tmean2: num  34 NA 34.2 47 NA ...
     $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
     $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...
    
    

B. Suppose we wanted to take the first 3 columns only. There are a few ways to do this. We could for example use numerical indices. But we can also use the names directly.

    name(chicago)[1:3]
    [1] "city" "tmpd" "dptp"
    
    
    subset = select(chicago, city:dptp)
    head(subset)
      city tmpd   dptp
    1 chic 31.5 31.500
    2 chic 33.0 29.875
    3 chic 33.0 27.375
    4 chic 29.0 28.625
    5 chic 32.0 28.875
    6 chic 40.0 35.125
   
Note: We used `head()` function to select only the first 6 rows in the dataframe. It also applies with the `tail()` function.


### select()

C. You can also omit variables using the `select()` function by using the negative sign. In this case we want to omit the variables **city** upto **dptp**.

    subset_omit = select(chicago, -(city:dptp))
    head(subset_omit)
                date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
        1 1987-01-01         NA   34.00000 4.250000  19.98810
        2 1987-01-02         NA         NA 3.304348  23.19099
        3 1987-01-03         NA   34.16667 3.333333  23.81548
        4 1987-01-04         NA   47.00000 4.375000  30.43452
        5 1987-01-05         NA         NA 4.750000  30.33333
        6 1987-01-06         NA   48.00000 5.833333  25.77233

D. The `select()` function also allows special syntax that allows you to specify variable names based on patterns. 

For example we want to:

- Keep every variable that **ends with a "2"**. We could do;

        subset = select(chicago, ends_with("2"))
        head(subset)
        'data.frame':   6940 obs. of  4 variables:
         $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
         $ pm10tmean2: num  34 NA 34.2 47 NA ...
         $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
        $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...

- Keep every variable that **ends with a "d"**. We could do;
     
        subset = select(chicago, starts_with("d"))
        str(subset)
        'data.frame':   6940 obs. of  2 variables:
        $ dptp: num  31.5 29.9 27.4 28.6 28.9 ...
        $ date: Date, format: "1987-01-01" "1987-01-02" ...

## filter()
The `filter()` function is used to extract subsets of rows from the data frame. This
function is similar to the existing `subset()` function R but is quite a bit faster in past experiences.

Suppose we want to extract the rows of Chicago data where the levels of pm25tmean2 are greater than 30.

    levels = filter(chicago, pm25tmean2 > 30)
    str(levels)
    'data.frame':   194 obs. of  8 variables:
     $ city      : chr  "chic" "chic" "chic" "chic" ...
    $ tmpd      : num  23 28 55 59 57 57 75 61 73 78 ...
     $ dptp      : num  21.9 25.8 51.3 53.7 52 56 65.8 59 60.3 67.1 ...
     $ date      : Date, format: "1998-01-17" "1998-01-23" ...
     $ pm25tmean2: num  38.1 34 39.4 35.4 33.3 ...
     $ pm10tmean2: num  32.5 38.7 34 28.5 35 ...
     $ o3tmean2  : num  3.18 1.75 10.79 14.3 20.66 ...
     $ no2tmean2 : num  25.3 29.4 25.3 31.4 26.8 ...

## summary()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
