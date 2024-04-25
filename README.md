R package development practice
================
2024-03-25

This is a repository for storaging all the resources for making the R
package “bbsTaiwan”

## Resources

#### Taiwan BBS

- [Taiwan BBS official website](https://sites.google.com/view/bbstaiwan)

- [Taiwan BBS 2022 annual report](chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/file:///C:/Users/sunny/Downloads/2022%E5%B9%B4BBS%20Taiwan%E5%B9%B4%E5%A0%B1.pdf)

- [Taiwan BBS analysis Github page](https://github.com/jerome-cjko/bbstaiwan_trend)

- [Use poptrend package to analyze BBS Taiwan data](https://www.sciencedirect.com/science/article/pii/S1470160X22013127#s0085)

- [Taiwan BBS data on GBIF](https://www.gbif.org/dataset/f170f056-3f8a-4ef3-ac9f-4503cc854ce0)

- [Taiwan BBS data on Google Drive](https://drive.google.com/drive/folders/1ex6EDkXv82mpEKcPkOYrQJ_anlu3pI1E?fbclid=IwAR38wYdRlz6swG-ffwWLrclVPkl1d6DshDTHD9rElGlJThweEeho9JtgkEE)

#### Publications from Jerome

- [BBS Taiwan as a book
  chapter](https://link.springer.com/chapter/10.1007/978-4-431-54783-9_3)

#### Workflow and modelling

- [bbsBayes package publication](chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://storage.googleapis.com/jnl-up-j-jors-files/journals/1/articles/329/submission/proof/329-1-5163-1-10-20210720.pdf)

- [rtrim package](https://github.com/SNStatComp/rtrim)

- [rgbif package to get GBIF
  data](https://inbo.github.io/tutorials/tutorials/r_gbif_checklist/)

- [Example R script for pulling data down from
  GBIF](https://github.com/ikea-shark/up_and_down_vis?fbclid=IwAR3I7V8kJrh9EZi42xR_Wtcw619QNpZBPucIu7lLaI8NNWN-9u-l_0GYTj8)

#### Package logo design

- [Tips to design hex
  logo](https://zhuhao.org/post/tips-on-designing-a-hex-sticker-for-rstats-packages/)

- [Required dimension](http://hexb.in/sticker.html)

- [hexSticker R package for creating logo in
  streamline](https://github.com/GuangchuangYu/hexSticker)

## Working note

#### 20240329

- Meeting with Mentor, check the current progress and the following
  steps

- Downloaded Taiwan species list from
  [here](https://www.bird.org.tw/basicpage/87)

- Downloaded BBS species list from
  [here](https://drive.google.com/drive/folders/16D7hLVajbBQ9pU5Y6SZem0KEA1l1zyiR)

- Worked on developing the function of translating the Chinese name to
  scientific name

#### 20240407

- Finished two main functions and is developing the third one

- Isolated all the required default data in the same script, these are
  the data needs to put into .rds format in the package

- Almost finished data visualization - need to clean up the GBIF data
  before moving forward, otherwise there might be too much to change

- Finished listing questions and set a meeting with Jerome

- Finished listing questions for programming with Eunseup

#### 20240414

- Finished the function for visualizing the GBIF extracted data

- Updated the workflow and the example code for the main bbsTaiwan repo

- Next: digging into the preparation code - clean the columns, drop
  rows, get environmental data if needed

#### 20240423

- Cleaned up the dataset default

- Next: have to deal with the multiple values issue in the `pivot_wider`
  in the event and the occurrence data

- Next: dig into data cleaning and get ready for modelling

#### 20240425

- Checked both rtrim and poptrend. Sent an request for poptrend anallysis.
- rtrim package is out of date - can't install in RStudio
- poptrend is published last year on CRAN, can potentially be an option
