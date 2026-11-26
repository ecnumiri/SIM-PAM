# SIM-PAM: Structured Illumination Photoacoustic Microscopy

This repository provides MATLAB codes and supporting experimental datasets for structured illumination photoacoustic microscopy (SIM-PAM). The codes are used for image reconstruction, image processing, resolution analysis, and field-of-view stitching associated with this study.

## 1. Repository Structure

```text
SIM-PAM/
│
├── ball/                   # Microsphere imaging data and processing
├── ear/data/               # Mouse-ear imaging data
├── functions/              # Auxiliary MATLAB functions and dependencies
│   ├── frc_analysis.m      # FRC analysis function
│   ├── Hadamard-single-pixel-imaging-main/
│   └── HIFI-SIM-main/
│
├── melanin/                # Melanin imaging data and processing
├── target/                 # Resolution target data
│
├── computeFRC.m            # Fourier ring correlation analysis
├── plot_ear.m              # Visualization of mouse-ear images
├── plot_melanin.m          # Visualization of melanin images
├── sample_ball.m           # Microsphere image processing
├── stiche.m                # Image stitching
└── txtGenSeq.m             # Acquisition sequence generation
```

## 2. Experimental Data

The experimental datasets used in this study are available through Google Drive:

**[Download SIM-PAM Experimental Datasets](https://drive.google.com/file/d/1rgfUn25n-XFV79NtT0o8Qzh6OlFaV9rG/view?usp=sharing)**

Download the dataset and extract the files into the corresponding directories before running the MATLAB scripts.

## 3. External Algorithm Dependencies

Two external MATLAB algorithm packages are required for the reconstruction workflow. These packages are maintained by their respective authors and are not original implementations of this repository.

### 3.1 Hadamard Single-Pixel Imaging

The Hadamard single-pixel imaging functions are available from:

https://github.com/zibangzhang/Hadamard-single-pixel-imaging

Download the repository using **Code → Download ZIP**, extract it, and place the resulting folder (`Hadamard-single-pixel-imaging-main`) inside the `functions/` directory.

### 3.2 HiFi-SIM Reconstruction

The HiFi-SIM reconstruction implementation is available from:

https://github.com/BenSmithLight/HIFI-SIM

Download the repository using **Code → Download ZIP**, extract it, and place the resulting folder (`HIFI-SIM-main`) inside the `functions/` directory.

The HiFi-SIM algorithm is based on the method described in:

Wen, G., Li, S., Wang, L. et al. High-fidelity structured illumination microscopy by point-spread-function engineering. *Light: Science & Applications* **10**, 70 (2021).

https://doi.org/10.1038/s41377-021-00513-w

Please refer to the original repositories for the corresponding software documentation and licensing terms.

## 4. Software Requirements

- MATLAB
- MATLAB Image Processing Toolbox
- Additional MATLAB toolboxes may be required by specific processing functions.

## 5. Usage Instructions

1. Download or clone this SIM-PAM repository.
2. Download the experimental datasets from the Google Drive link and extract them into the appropriate directories.
3. Download the Hadamard single-pixel imaging and HiFi-SIM packages from the links provided above and place them inside `functions/`.
4. Open MATLAB and set the SIM-PAM repository root as the working directory.
5. Add the repository and all subdirectories to the MATLAB search path:

```matlab
addpath(genpath(pwd));
```

6. Open and run the corresponding MATLAB scripts according to the sample type and analysis task.

**Note:** Some scripts may require adjustment of input data paths and reconstruction parameters according to the local dataset directory.

## 6. Main Processing Functions

| Script | Description |
|---|---|
| `sample_ball.m` | Microsphere image processing and visualization |
| `plot_ear.m` | Mouse-ear image processing and visualization |
| `plot_melanin.m` | Melanin image processing and visualization |
| `computeFRC.m` | Quantitative resolution analysis using FRC |
| `stiche.m` | Image stitching for extended-field-of-view imaging |
| `txtGenSeq.m` | Generation of acquisition sequences |

## 7. Citation

If you use these codes or datasets in your research, please cite the associated SIM-PAM publication

## 8. Contact

For questions regarding the codes, datasets, or implementation, please contact the corresponding author.
