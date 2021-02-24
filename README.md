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
    

To view the basic characteristics of the dataset we can use `dim()` and `str()` functions.

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

    

Suppose we wanted to take the first 3 columns only. There are a few ways to do this. We
could for example use numerical indices. But we can also use the names directly.

    name(chicago)[1:3]
    

![dim output](put url here)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
