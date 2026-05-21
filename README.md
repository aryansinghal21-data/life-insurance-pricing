# ❤️ Life Insurance Mortality Risk & Premium Pricing Model
*Life Insurance | Actuarial Pricing | Python | SQL | Risk Tiering | ML Scoring*

---

## 📋 Business Problem
Life insurance underwriting requires accurate mortality risk assessment. This project builds a data-driven actuarial pricing engine using clinical risk factors to classify applicants into risk tiers and calculate risk-adjusted premiums.

---

## 🎯 Key Results

| Metric | Value |
|--------|-------|
| Best Model | Gradient Boosting |
| AUC-ROC | ~0.90 (5-fold cross-validated) |
| Risk Tiers | 6 tiers: Preferred Plus → Decline |
| Premium Range | ~$340/yr (Preferred Plus) to $2,800+/yr (High Risk) |
| Premium Spread | ~8× between best and worst tier |
| Portfolio Coverage | 297 policies fully priced |

---

## 📊 Key Visualisations

> Risk Factor Distributions | Underwriting Risk Map | ROC Curves | Premium Tier Chart

---

## 🔧 Methodology

1. **SQL Analysis** — Mortality risk rates by age band, gender, cholesterol
2. **EDA** — Clinical risk factor distributions comparing high vs low risk patients
3. **Risk Scoring Model** — Gradient Boosting classifier for mortality risk
4. **Actuarial Pricing Engine** — Base mortality table + multiplicative loading factors
5. **Risk Tiering** — 6-tier classification (Preferred Plus → Decline)
6. **Portfolio Analysis** — Entire dataset priced and analysed

---

## 💡 Key Insights

- Exercise-induced angina, major vessel count, ST depression are strongest mortality predictors
- Male patients show 30–40% higher heart disease prevalence → supports gender-based pricing
- Premium spread of 8× between best and worst tier is actuarially justified
- Automated scoring processes 297 applications in under 1 second

---

## 🛠️ Tools & Technologies
`Python` `SQL` `SQLite` `Scikit-learn` `Actuarial Life Tables` `Pandas` `Matplotlib` `Seaborn`

---

## 🗂️ Dataset
**Source:** UCI Machine Learning Repository — Cleveland Heart Disease Dataset
**Link:** https://archive.ics.uci.edu/dataset/45/heart+disease
**Size:** 297 patients × 14 clinical features

---

## 🚀 How to Run

```bash
git clone https://github.com/aryansinghal21-data/life-insurance-pricing
cd life-insurance-pricing
pip install -r requirements.txt
jupyter notebook notebooks/life_insurance_pricing.ipynb
```

---

## 👤 Author
**Aryan Singhal** | Aspiring Actuarial Data Analyst
[LinkedIn](https://www.linkedin.com/in/aryansinghal21/) | [Email](mailto:aryansinghal821@gmail.com)ogo=gmail)](mailto:aryasinghal821@gmail.com)
