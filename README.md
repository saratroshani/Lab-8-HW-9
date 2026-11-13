# Lab 8 - Logit and Probit Models
# HW 9
# Sara Troshani

This lab continues the analysis from Lab 7 using the same couples dataset.

The outcome variable is `he_older_6`, which equals 1 when the husband is more than 6 years older than the wife.

## What I Did

For this lab, I:

- Compared OLS, Logit, and Probit models
- Compared prediction accuracy across the three models
- Tested a 0.5 cutoff and compared it with the average predicted probability
- Looked at model accuracy across different age groups
- Added Age Squared to see if it improved the model
- Compared false positives and false negatives

## Main Results

- Logit had the highest accuracy at about 57.1%
- Probit had about 56.2% accuracy
- OLS had about 54.1% accuracy
- A 0.5 cutoff was not a good cutoff because both Logit and Probit predicted every observation as 0
- The model performed much worse for younger couples and much better for older couples
- Adding Age Squared improved the model fit, but prediction accuracy fell to about 51.4%
- The Age Squared model had fewer false negatives but more false positives


## Model Accuracy Comparison

Logit had the highest accuracy out of the three models.


<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/ee9a45ae-94d2-4e4d-8025-6ac80c7bcd89" />


## Model Accuracy by Age Group

The model performed very differently across age groups.

Accuracy was much lower for younger couples and higher for older couples.

For people under 30, accuracy was about 13.4%.

For the 60+ group, accuracy was about 81%.


<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/6bd89d2f-dab5-4d04-b58d-d35f7d8c48ae" />


## False Positive vs False Negative Tradeoff

Adding Age Squared lowered false negatives from 24,423 to 17,653.

However, false positives increased from 132,767 to 160,401.

This means the new model found more positive cases, but it also made more false positive mistakes.


<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/72b3d9d6-5e99-4403-b806-9a6fc2edc4ba" />


## Conclusion

The Logit model had the highest overall accuracy compared with OLS and Probit.

The cutoff also mattered. A cutoff of 0.5 did not work well for this outcome.

The model performed much worse for younger couples than for older couples.

Adding Age Squared improved the model fit, but it did not improve prediction accuracy.

Overall, it is important to look at more than just accuracy when comparing models.

