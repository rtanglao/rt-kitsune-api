# rt-kitsune-api
roland's experiments with kitsune api for sumo aka support.mozilla.org

## 22september2018 
### 22september2018 how to open browser from wsl i.e. my previous blog post was wrong, no selenium server required
* blog post: http://rolandtanglao.com/2018/09/22/p1-launchy-works-on-wsl-if-you-set-browser-environment-variable/

* in bash:
```bash
export BROWSER='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
```
* and then in ruby launchy just works:
```ruby
require 'launchy'
Launchy.open("https://support.mozilla.org")
```

## 17september2018

### 17september2018 mongodb query to get questions for Thursday13Sept-Sat15Sept2018

```json
{
    "created": {
        "$gte": ISODate("2018-09-13T00:00:00-07:00"),
        "$lt" : ISODate("2018-09-16T00:00:00-07:00")
    }
}
```

### 17september2018 how to compute an operating system tag
* the following code is from [tim smith](https://github.com/tdsmith), thanks Tim!

```r
os_tags <-
read_csv("
  https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master/FF62_WEEK1/16september2018-tags-5-11september2018.csv") 
  %>%
    filter(
      grepl("^windows-", tag) |
             (tag == "mac-os") |
             (tag == "linux")) 
  %>%
 mutate(os=ifelse(grepl("^windows-", tag), "windows", tag))
```
### 17september2018 how to read a file of tags and collapse

* test.txt has:
```
rolandff62experiment
ff62

```

```r
test.txt <- read.table("machine-tags.txt") # with new line at end of file!
> paste(test.txt[,1],collapse="|")
[1] "rolandff62experiment|ff62"
```


## 16september2018

### 16september2018 remove machine and operating system tags raw R Studio

* the following can be done more concisely with:
```  filter(str_detect(rowname, "Merc|Toy"))```
see: https://sebastiansauer.github.io/dplyr_filter/ for full details

```r
tags_gt10_remove_common_tags <-
tags_count_gt_10 %>%
filter(tag != "desktop" &
tag != "escalate" &
tag != "beta" &
tag != "esr" &
tag != "firefox-520" &
tag != "firefox-600" &
tag != "firefox-610" &
tag != "firefox-6102" &
tag != "firefox-620" &
tag != "firefox-630" &
tag != "linux" &
tag != "mac-os" &
tag != "needsinfo" &
tag != "other" &
tag != "rolandff62experiment" &
tag != "windows-10" &
tag != "windows-7" &
tag != "windows-81" &
tag != "windows-xp" )
View(tags_with_counts)
View(tags_gt10_remove_common_tags)
p3 = ggplot(data=tags_gt10_remove_common_tags, aes(x=tag, y=n))
p3 = p3 + geom_bar(stat = "identity")
p3 = p3 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p3
```

Output:

![Week 1 Firefox 62 Desktop SUMO Forum desktop tags with all operating system tags removed](https://github.com/rtanglao/rt-kitsune-api/blob/master/FF62_WEEK1/Operating%20System%20tags%20removed%20for%20the%20first%20week%20of%20Firefox%20Desktop%2062%20i.e.%20September%205-11Rplot02.png)


### 16september2018 raw R Studio

```r
install.packages("ggplot2")
library(ggplot2)
tags = read.csv(file = "https://raw.githubusercontent.com/rtanglao/rt-kitsune-api/master//FF62_WEEK1/16september2018-tags-5-11september2018.csv", stringsAsFactors = F)
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

![ All SUMO AAQ tags for the first week of Firefox Desktop 62 i.e. September 5-11, 2018](https://github.com/rtanglao/rt-kitsune-api/blob/master//FF62_WEEK1/sumo-firefox-desktop-62-week1-05-11september2018-all-tags-count-gt-10-Rplot02.png)

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
