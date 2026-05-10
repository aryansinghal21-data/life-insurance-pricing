# Data — Project 3: Life Insurance Pricing

## Dataset: UCI Cleveland Heart Disease Dataset

**Source:** UCI Machine Learning Repository  
**Direct URL:** https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data  
**Downloaded automatically** by the notebook on first run and saved locally as `heart_disease.csv`  
**Original study:** Cleveland Clinic Foundation

## Dataset Properties

| Property | Value |
|----------|-------|
| Total Patients | 297 (after removing 6 rows with missing values) |
| Features | 13 clinical variables + 1 target |
| High Risk (heart disease) | 137 patients (46.1%) |
| Low Risk (no disease) | 160 patients (53.9%) |
| License | Free for academic and research use |

## Why This Dataset for Life Insurance?

Life insurance underwriting is based on the same clinical variables that predict heart disease and mortality. When a person applies for life insurance, they take a medical exam measuring these exact factors. The presence of heart disease is used as a **mortality risk proxy** — patients with heart disease face elevated mortality rates, which translates directly into higher insurance premiums.

## Column Descriptions

| Column | Medical Meaning | Insurance Relevance |
|--------|----------------|---------------------|
| `age` | Age in years | Primary rating factor |
| `sex` | 1=Male, 0=Female | Gender-based pricing |
| `cp` | Chest pain type (1-4) | Cardiac risk indicator |
| `trestbps` | Resting blood pressure (mmHg) | Hypertension loading factor |
| `chol` | Serum cholesterol (mg/dl) | Cholesterol loading factor |
| `fbs` | Fasting blood sugar > 120 mg/dl | Diabetes marker |
| `restecg` | Resting ECG results (0-2) | Cardiac health indicator |
| `thalach` | Maximum heart rate achieved | Exercise capacity |
| `exang` | Exercise induced angina (1=yes) | Strongest single predictor |
| `oldpeak` | ST depression during exercise | Cardiac stress measure |
| `slope` | ST segment slope | Severity indicator |
| `ca` | Number of major vessels blocked (0-3) | Direct disease indicator |
| `thal` | Thalassemia type | Blood disorder |
| `target` | Heart disease present (1=yes, 0=no) | **HIGH RISK flag for pricing** |

## Citation

Detrano, R., et al. (1989). International application of a new probability algorithm for the diagnosis of coronary artery disease. *American Journal of Cardiology*, 64(5), 304-310.
