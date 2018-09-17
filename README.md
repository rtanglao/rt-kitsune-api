# rt-kitsune-api
roland's experiments with kitsune api for sumo aka support.mozilla.org

## 16september2018

### 16september2018 raw R Studio

```r
install.packages("ggplot2")
library(ggplot2)
tags = read.csv(file = "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/16september2018-tags-5-11september2018.csv", stringsAsFactors = F)
p = ggplot(data=tags, aes(x=tag), stat="count")
p = ggplot(data=tags, aes(x=tag))
p= p + geom_bar(stat="count"
p
p= p + geom_bar(stat="count")
p
tags_with_counts <-
tags %>%
group_by(tag) %>%
count()
install.packages("tidyverse")
library(tidyverse)
tags_with_counts <-
tags %>%
group_by(tag) %>%
count()
tags_count_gt_10 <-
tags_with_counts %>%
filter(n >10)
p2 = ggplot(data=tags_count_gt_10, aes(x=tags))
p2 = p2 + geom_bar()
p2
p2 = p2 + geom_bar(stat="identity")
p2
tags_count_gt_10 <- tags_count_gt_10 %>% arrange(n)
p2 = ggplot(data=tags_count_gt_10, aes(x=tag))
p2 = p2 + geom_bar()
p2 = p2 + geom_bar(stat="identity")
p2 = p2 + geom_bar()
p2 = ggplot(data=tags_count_gt_10, aes(x=tag))
p2 = p2 + geom_bar(stat="identity")
p2 = ggplot(data=tags_count_gt_10, aes(x=tag, y=n))
p2 = p2 + geom_bar(stat="identity")
p2 = p2 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p2
```

Output:

![ All SUMO AAQ tags for the first week of Firefox Desktop 62 i.e. September 5-11, 2018](https://github.com/rtanglao/rt-kitsune-api/blob/master/sumo-firefox-desktop-62-week1-05-11september2018-all-tags-count-gt-10-Rplot02.png)

### 16september2018 get tags for week 1 of firefox 62 for desktop

```bash
./print-csv-tags-unixtime.rb 2018 9 5 2018 9 11 >16september2018-tags-5-11september2018.csv
```


## 11September2018 answer API

* like the questionAPI this was discovered in [jscher2000's myq.html code](https://github.com/jscher2000/My-SuMo-Questions/blob/master/myq.html)!
* sample answer API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/answerTestAPI.rb 
  * sample API json response: https://github.com/rtanglao/rt-kitsune-api/blob/master/sampleAnswerTestAPIoutput.md
* sample reply API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/testAPI.rb
* API is:```https://support.mozilla.org/api/2/answer/?format=json&id=<question_id>``` 
  * where ```<question_id>``` is an integer question id!

## 10September2018 how to open tab in a browser (doesn't work in WSL)
* more info on why it doesn't work in WSL:
  * http://rolandtanglao.com/2018/09/09/p1-still-cannot-launch-firefox-from-wsl-without-lots-of-yakshaving/

```bash
./open-day-in-browser.rb 2018 9 10 2>11september2018-open-mon10september2018-sumo-firefox-quesions-stderr.txt
```

## 08September2018 how to run

## 08September2018 setup environment
```bash
cd ~/GIT/rt-kitsune-api
. setupDatabase
pushd ~/rtanglao/MONGODB_DATABASES/KITSUNE_QUESTIONS
# mongod --config --dbpath . & # on Windows Subystem for Linux
mongod --dbpath . & # on Mac OS X, should work on Windows, forgot to delete --config for some reason on Windows !
popd
```
## 08September2018 populate database
```bash
./get-sumo-firefox-questions-from-api.rb 2018 09 05
```
