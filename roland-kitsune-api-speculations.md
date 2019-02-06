These are speculations only. Not supported by me or anybody else. 

**PLEASE: Do not contact any folks mentioned here for support or for questions!**

1. found out about this API via ace volunteer's code for [myQ.html](https://github.com/jscher2000/My-SuMo-Questions/blob/master/myq.html)
1. there are no docs on readthedocs (there are docs for the very limited v1 API, this is the v2 API)
1. i believe this API was implemented for BuddyUp
1. most of the API is normal django so if you know django you can figure it out, i don't know django
1. i believe mythmon and others worked on this API
1. i believe there is a url parameter just to get modified questions and answers, not just the ones created but i've never tried to get just modified questions or answers
1. to make the API practical in production there needs to be a way to ask for items from a particular time period and fortunately there's an open github issue for that :-) (and probably more github issues need to created to make this API useful in production)
    * https://github.com/mozilla/kitsune/issues/3332
1. sample question API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/testAPI.rb
    * sample question API json response: https://github.com/rtanglao/rt-kitsune-api/blob/master/sample-question-api-result.md
    * API is:https://support.mozilla.org/api/2/question/?format=json&product=firefox&locale=en-US 
1. sample answer API code: https://github.com/rtanglao/rt-kitsune-api/blob/master/answerTestAPI.rb
    * sample API json response: https://github.com/rtanglao/rt-kitsune-api/blob/master/sampleAnswerTestAPIoutput.md
    * API is:https://support.mozilla.org/api/2/answer/?format=json&id=<question_id> where <question_id> is an integer question id!
1. i believe there is a similar user API (which jscher might use in myQ) but i've never used it!
