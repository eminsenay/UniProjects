(defglobal
  ?*foundIllness* = 0
)
(deffunction MAIN::readfile (?p0))

(deffunction MAIN::readfile
   (?filename)
   (open ?filename filen "r")
   (bind ?nextline (readline filen))
   (while (neq ?nextline EOF) do      
      (assert (satir ?nextline))
      (bind ?nextline (readline filen)))
   (close filen))
(readfile "illness.txt")
(defrule initializeIllness
  ?factNo <- (satir ?str)
=>
  (bind ?ilkvirgul (str-index "," ?str))
  (bind ?illnessname (sub-string 1 (- ?ilkvirgul 1) ?str))
  (bind ?uzunluk (str-length ?str))
  (bind ?gerikalan (sub-string (+ ?ilkvirgul 1) ?uzunluk ?str))
  (bind ?ikincivirgul (str-index "," ?gerikalan))
  (bind ?firstprob (sub-string 1 (- ?ikincivirgul 1) ?gerikalan))  
  (bind ?str ?gerikalan)
  (bind ?sayi 0)
  (while (neq ?sayi "999")
    (bind ?symptomNo 0)
    (bind ?prob1 2)
    (bind ?prob2 2) 
    (loop-for-count (?cnt1 1 3) do  
      (bind ?ilkvirgul (str-index "," ?str))
      (bind ?uzunluk (str-length ?str))
      (bind ?gerikalan (sub-string (+ ?ilkvirgul 1) ?uzunluk ?str))
      (if (eq ?gerikalan "999") then 
        (break)) 
      (bind ?ikincivirgul (+ (str-index "," ?gerikalan) ?ilkvirgul))
      (bind ?sayi (sub-string (+ ?ilkvirgul 1) (- ?ikincivirgul 1) ?str))
      (if (eq ?sayi "999") then 
        (break)) 
      (bind ?str ?gerikalan)
      (if (eq ?cnt1 1) then
        (bind ?symptomNo ?sayi)
      )
      (if (eq ?cnt1 2) then
        (bind ?prob1 ?sayi)
      )
      (if (eq ?cnt1 3) then
        (bind ?prob2 ?sayi)
      )
    )
    (if (or (eq ?sayi "999") (eq ?gerikalan "999")) then 
        (break)) 
    (assert (illnessSymptom ?illnessname ?symptomNo ?prob1 ?prob2))    
    (assert (lambda ?symptomNo 1))
    (assert (probability ?illnessname (string-to-field ?firstprob) (- 1 (string-to-field ?firstprob))))
  )
  (retract ?factNo)
)
(run)
(defrule calculateProbability
  (declare (salience 4))  
  ?factNo1 <- (illnessSymptom ?illnessName ?symptomNo ?prob1 ?prob2)  
  ?factNo2 <- (probability ?illnessName ?p1 ?p2)  
  (lambda ?symptomNo ?lambdaVal)
  (symptom ?symptomNo ?symptomquestion ?symptomtype 1)
=>
  (retract ?factNo1)
  (retract ?factNo2)
  (bind ?tmp (* ?lambdaVal ?p1))
  (assert (probability ?illnessName ?tmp ?p2))
  (bind ?prob (/ ?tmp (+ ?tmp ?p2)))
  (if (> ?prob 0.95) then
    (bind ?yuzde (* ?prob 100))
    (printout t crlf crlf "You are with " ?yuzde "% " ?illnessName crlf)
    (printout t "If you want to continue, continue aswering; o/w press a" crlf crlf)
  )
)
(run)
(readfile "symptoms.txt")
(defrule initializeSymptoms
  ?factNo <- (satir ?str)
=>
  (if (neq (str-length ?str) 0) then  
    (bind ?ilkvirgul (str-index "," ?str))
    (bind ?symptomno (sub-string 1 (- ?ilkvirgul 1) ?str))
    (bind ?uzunluk (str-length ?str))
    (bind ?symptomQuestion (sub-string (+ ?ilkvirgul 2) ?uzunluk ?str))
    (assert (symptom ?symptomno ?symptomQuestion 1 0))
  )
  (retract ?factNo)
)
(run)
(defrule finalCalculation  
  (declare (salience 3)) 
  ?factNo1 <- (probability ?illnessName ?p1 ?p2)
=>
  (assert (finalProb ?illnessName (/ ?p1 (+ ?p1 ?p2))))
  (retract ?factNo1)
)
(defrule printProbs
  (declare (salience 2)) 
  ?factNo1 <- (finalProb ?illnessName ?prob)
=>
  (if (> ?prob 0.80) then
    (bind ?yuzde (* ?prob 100))
    (printout t crlf "You are with " ?yuzde "% " ?illnessName crlf)
    (bind ?*foundIllness* 1))
  )
  (retract ?factNo1)
  (assert (finished 1))
)
(defrule uncertainty
  (declare (salience 1))
  (finished 1)
=>
  (if (eq ?*foundIllness* 0) then
    (printout t crlf "I am not very sure of your illness." crlf)
    (printout t "No illness has more probability than 0.8" crlf)
  )
)
(defrule noMoreQuestions
  (declare (salience 5))
  ?factNo <- (illnessSymptom ? ? ? ?)
  (noMoreAnswer 1)
=>
  (retract ?factNo)
)  
(defrule answerOfSymptom
  (declare (salience 4)) 
  ?symptomFact <- (symptom ?symptomno ?symptomquestion ?symptomtype 0)
  (illnessSymptom ?illnessName ?symptomno ?prob1 ?prob2)
  ?factNo <- (lambda ?symptomno $?)
=>
  (printout t ?symptomquestion)
  (printout t " (yES/nO/aBORT)" )
  (bind ?answer (read))              
  (if (eq ?answer y) then
    (bind ?p1 (string-to-field ?prob1))
    (bind ?p2 (string-to-field ?prob2))
    (if (eq ?p2 0) then
    	(bind ?p2 0.0000000001)
    )    
    (bind ?oran (/ ?p1 ?p2))
    (retract ?factNo)
    (assert (lambda ?symptomno ?oran))
  else 
    (if (eq ?answer a) then
      (assert (noMoreAnswer 1))
    else
      (bind ?p1 (string-to-field ?prob1))
      (bind ?p2 (string-to-field ?prob2))
      (if (eq ?p2 1) then
    	  (bind ?p2 0.0000000001)
      )    
      (bind ?oran (/ (- 1 ?p1) (- 1 ?p2)))
      (retract ?factNo)
      (assert (lambda ?symptomno ?oran))
    )
  )
  (retract ?symptomFact)
  (assert (symptom ?symptomno ?symptomquestion ?symptomtype 1))        
)
(run)
