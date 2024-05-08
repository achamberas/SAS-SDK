%let access_token = edddd755-a5f1-4065-b637-7c32b98da1e4;

filename request  temp;
data _null_;
    file request;
    input;
    put _infile_;
datalines;
{
  "configuration": {
    "baseline": "previous",
    "unit": 0,
   "fill_missing": 0
  },
  "data": [
    {
    "SUBJID": "GTIMEPO010",
    "visitNumber": 1,
    "visitDate": "2017-06-21",
    "bmi": {
        "height": 1.00,
        "weight": 30 
    },
    "bloodPressure": {
        "systolic": 120,
        "diastolic": 75
    },
    "medication": {
        "lipidIntent": 0,
        "bpIntent": 0,
        "glucoseIntent": 0
    },
    "labs": {
        "ldl": 2.5,
        "LDLTarget": 2.586,
        "hba1c": 8.2
    },
    "bmd": {
        "femoral": 0.001,
        "lumbosacral": 0.001
    },
    "steroidMyopathy": {
        "myopathySeverity": 0
    },
    "skinToxicity": {
        "hirsutism": 0,
        "acneiformRash": 0,
        "easyBruising": 1,
        "atrophyStriae": 1,
        "erosionTearUlceration": 0
    },
    "neuropsychiatric": {
        "insomnia": 0,
        "mania": 0,
        "cognitiveImpairment": 0,
        "depression": 0,
        "psychosis": 0,
        "steroidViolence": 0
    },
    "infections": {
        "grade3Infection": 1,
        "grade4Infection": 1,
        "grade5Infection": 1,
        "zoster": 1,
        "candidiasis": 1
    },
    "events": {
        "hypertensiveEmergency": 0,
        "bpPres": 0
    }
    },
    {
    "SUBJID": "GTIMEPO010",
    "visitNumber": 2,
    "visitDate": "2018-06-20",
    "bmi": {
        "height": 1.00,
        "weight": 30 
    },
    "bloodPressure": {
        "systolic": 130,
        "diastolic": 75
    },
    "medication": {
        "lipidIntent": 0,
        "bpIntent": 0,
        "glucoseIntent": 0
    },
    "labs": {
        "ldl": 1.5,
        "LDLTarget": 2.586,
        "hba1c": 6.8
    },
    "bmd": {
        "femoral": 0.001,
        "lumbosacral": 0.001
    },
    "steroidMyopathy": {
        "myopathySeverity": 0
    },
    "skinToxicity": {
        "hirsutism": 0,
        "acneiformRash": 0,
        "easyBruising": 2,
        "atrophyStriae": 0,
        "erosionTearUlceration": 0
    },
    "neuropsychiatric": {
        "insomnia": 0,
        "mania": 0,
        "cognitiveImpairment": 0,
        "depression": 0,
        "psychosis": 1,
        "steroidViolence": 1
    },
    "infections": {
        "grade3Infection": 0,
        "grade4Infection": 0,
        "grade5Infection": 0,
        "zoster": 1,
        "candidiasis": 1
    },
    "events": {
        "hypertensiveEmergency": 0,
        "bpPres": 0
    }
    },
    {
    "SUBJID": "GTIMEPO010",
    "visitNumber": 3,
    "visitDate": "2019-06-20",
    "bmi": {
        "height": 1.00,
        "weight": 33 
    },
    "bloodPressure": {
        "systolic": 130,
        "diastolic": 75
    },
    "medication": {
        "lipidIntent": 0,
        "bpIntent": 0,
        "glucoseIntent": 0
    },
    "labs": {
        "ldl": 1.5,
        "LDLTarget": 2.586,
        "hba1c": 6.8
    },
    "bmd": {
        "femoral": 0.001,
        "lumbosacral": 0.001
    },
    "steroidMyopathy": {
        "myopathySeverity": 0
    },
    "skinToxicity": {
        "hirsutism": 0,
        "acneiformRash": 0,
        "easyBruising": 2,
        "atrophyStriae": 0,
        "erosionTearUlceration": 0
    },
    "neuropsychiatric": {
        "insomnia": 0,
        "mania": 0,
        "cognitiveImpairment": 0,
        "depression": 0,
        "psychosis": 1,
        "steroidViolence": 1
    },
    "infections": {
        "grade3Infection": 0,
        "grade4Infection": 0,
        "grade5Infection": 0,
        "zoster": 1,
        "candidiasis": 1
    },
    "events": {
        "hypertensiveEmergency": 0,
        "bpPres": 0
    }
    }
  ]
}
;
run;

filename response  '/home/u63579919/response.txt';
filename headout   '/home/u63579919/headout.txt';
/* filename jmap  '/home/u63579919/jmap.txt'; */
filename minmap "/home/u63579919/minmap.txt";

proc http
    url="https://service-staging.steritas.com/api/v1/agti/calculateScore"
    method="POST"
    in = request
    out = response
	headerout = headout;
    headers   "Content-Type" = "application/json" "access_token" = "&access_token.";
run;


/* create a mapping of the response to a dataset */
/*
data _null_;
infile datalines;
file minmap;
input;
put _infile_;
datalines;
{
  "DATASETS": [
    {
      "DSNAME": "scores",
      "TABLEPATH": "/root/score",
      "VARIABLES": [
        {
          "NAME": "SUBJID",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/SUBJID",
          "CURRENT_LENGTH": 136
        },
        {
          "NAME": "visitNumber",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/visitNumber"
        },
        {
          "NAME": "visitDate",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/visitDate",
          "CURRENT_LENGTH": 25
        },
        {
          "NAME": "bodyMassIndex_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/bodyMassIndex/score"
        },
        {
          "NAME": "bodyMassIndex_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/bodyMassIndex/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "bloodPressure_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/bloodPressure/score"
        },
        {
          "NAME": "bloodPressure_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/bloodPressure/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "boneDensity_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/boneDensity/score"
        },
        {
          "NAME": "boneDensity_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/boneDensity/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "steroidMyopathy_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/steroidMyopathy/score"
        },
        {
          "NAME": "steroidMyopathy_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/steroidMyopathy/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "infection_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/infection/score"
        },
        {
          "NAME": "infection_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/infection/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "lipids_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/labs/lipids/score"
        },
        {
          "NAME": "lipids_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/labs/lipids/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "glucoseTolerance_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/labs/glucoseTolerance/score"
        },
        {
          "NAME": "glucoseTolerance_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/labs/glucoseTolerance/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_hirsutism_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/hirsutism/score"
        },
        {
          "NAME": "skinToxicity_hirsutism_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/skinToxicity/hirsutism/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_acneiformRash_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/acneiformRash/score"
        },
        {
          "NAME": "skinToxicity_acneiformRash_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/skinToxicity/acneiformRash/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_easyBruising_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/easyBruising/score"
        },
        {
          "NAME": "skinToxicity_easyBruising_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/skinToxicity/easyBruising/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_atrophyStriae_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/atrophyStriae/score"
        },
        {
          "NAME": "skinToxicity_atrophyStriae_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/skinToxicity/atrophyStriae/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_erosionTear_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/erosionTearUlceration/score"
        },
        {
          "NAME": "skinToxicity_erosionTear_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/skinToxicity/erosionTearUlceration/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "skinToxicity_min_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/min"
        },
        {
          "NAME": "skinToxicity_max_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/skinToxicity/max"
        },
        {
          "NAME": "neuro_insomnia_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/insomnia/score"
        },
        {
          "NAME": "neuro_insomnia_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/insomnia/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_mania_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/mania/score"
        },
        {
          "NAME": "neuro_mania_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/mania/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_cognitiveImpairment_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/cognitiveImpairment/score"
        },
        {
          "NAME": "neuro_cognitiveImpairment_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/cognitiveImpairment/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_depression_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/depression/score"
        },
        {
          "NAME": "neuro_depression_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/depression/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_psychosis_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/psychosis/score"
        },
        {
          "NAME": "neuro_psychosis_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/psychosis/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_steroidViolence_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/steroidViolence/score"
        },
        {
          "NAME": "neuro_steroidViolence_label",
          "TYPE": "CHARACTER",
          "PATH": "/root/score/neuropsychiatric/steroidViolence/label",
          "CURRENT_LENGTH": 84
     	},
        {
          "NAME": "neuro_min_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/min"
        },
        {
          "NAME": "neuro_max_score",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/neuropsychiatric/max"
        },
        {
          "NAME": "cws",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/csw"
        },
        {
          "NAME": "ais",
          "TYPE": "NUMERIC",
          "PATH": "/root/score/ais"
        }
      ]
    }
  ]
}
;
run;
*/

/* map json paths and load to dataset */
libname results JSON fileref=response map=minmap;

data out;
 set results.scores;
run;

proc print data=out; run;
