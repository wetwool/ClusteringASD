#!/bin/tcsh

set study = $argv[1]

foreach hemi (lh rh)
  foreach smoothing (10)
    foreach meas (volume thickness)
      mris_preproc --fsgd FSGD/{$study}.fsgd \
        --cache-in {$meas}.fwhm{$smoothing}.fsaverage \
        --target fsaverage \
        --hemi {$hemi} \
        --out {$hemi}.{$meas}.{$study}.{$smoothing}.mgh
    end
  end
end

foreach hemi (lh rh)
  foreach smoothness (10)
    foreach meas (area thickness)
        mri_glmfit \
        --y {$hemi}.{$meas}.{$study}.{$smoothness}.mgh \
        --fsgd FSGD/{$study}.fsgd \
        --C Contrasts/CB-HC.mtx \
        --C Contrasts/HC-CB.mtx \
        --surf fsaverage {$hemi}  \
        --cortex  \
        --glmdir {$hemi}.{$meas}.{$study}.{$smoothness}.glmdir
    end
  end
end