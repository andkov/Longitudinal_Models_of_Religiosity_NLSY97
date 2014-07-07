m7R_call<- c("
modnum <-lmer (attend ~ 
                 1  + timec + timec2 + timec3
               + cohort + cohort:timec + cohort:timec2 + cohort:timec3
               + (1 | id),
               data = ds, REML=FALSE, 
               control=lmerControl(optCtrl=list(maxfun=20000)))
")

m7R_condFE<- c("
  (FE["(Intercept)"])         +(FE["cohort"]*dsp$cohort)
  +(FE["timec"]*dsp$timec)    +(FE["cohort:timec"]*dsp$cohort*dsp$timec)
  +(FE["timec2"]*dsp$timec2)  +(FE["cohort:timec2"]*dsp$cohort*dsp$timec2)
  +(FE["timec3"]*dsp$timec3)  +(FE["cohort:timec3"]*dsp$cohort*dsp$timec3)
")


# Model equation in MathJax:LaTeX
m7R_LaTeX
\[\begin{array}{l}{y_{ti}} = {\beta _{0i}} + {\beta _{1i}}time{c^{}}_t + {\beta _{2i}}time{c^2}_t + {\beta _{3i}}time{c^3}_t + {\varepsilon _{ti}}\\{\beta _{0i}} = {\gamma _{00}} + {\gamma _{01}}cohor{t_i} + {u_{0i}}\\{\beta _{1i}} = {\gamma _{10}} + {\gamma _{11}}cohor{t_i}\\{\beta _{2i}} = {\gamma _{20}} + {\gamma _{21}}cohor{t_i}\\{\beta _{3i}} = {\gamma _{30}} + {\gamma _{31}}cohor{t_i}\end{array}\]

# Same equation in MathJax:MathML
<math display='block'>
  <semantics>
  <mtable columnalign='left'>
  <mtr>
  <mtd>
  <msub>
  <mi>y</mi>
  <mrow>
  <mi>t</mi><mi>i</mi></mrow>
  </msub>
  <mo>=</mo><msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>0</mn><mi>i</mi></mrow>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>1</mn><mi>i</mi></mrow>
  </msub>
  <mi>t</mi><mi>i</mi><mi>m</mi><mi>e</mi><msup>
  <mi>c</mi>
  <mrow></mrow>
  </msup>
  <msub>
  <mrow></mrow>
  <mi>t</mi>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>2</mn><mi>i</mi></mrow>
  </msub>
  <mi>t</mi><mi>i</mi><mi>m</mi><mi>e</mi><msup>
  <mi>c</mi>
  <mn>2</mn>
  </msup>
  <msub>
  <mrow></mrow>
  <mi>t</mi>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>3</mn><mi>i</mi></mrow>
  </msub>
  <mi>t</mi><mi>i</mi><mi>m</mi><mi>e</mi><msup>
  <mi>c</mi>
  <mn>3</mn>
  </msup>
  <msub>
  <mrow></mrow>
  <mi>t</mi>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B5;</mi>
  <mrow>
  <mi>t</mi><mi>i</mi></mrow>
  </msub>
  
  </mtd>
  </mtr>
  <mtr>
  <mtd>
  <msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>0</mn><mi>i</mi></mrow>
  </msub>
  <mo>=</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>00</mn></mrow>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>01</mn></mrow>
  </msub>
  <mi>c</mi><mi>o</mi><mi>h</mi><mi>o</mi><mi>r</mi><msub>
  <mi>t</mi>
  <mi>i</mi>
  </msub>
  <mo>+</mo><msub>
  <mi>u</mi>
  <mrow>
  <mn>0</mn><mi>i</mi></mrow>
  </msub>
  
  </mtd>
  </mtr>
  <mtr>
  <mtd>
  <msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>1</mn><mi>i</mi></mrow>
  </msub>
  <mo>=</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>10</mn></mrow>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>11</mn></mrow>
  </msub>
  <mi>c</mi><mi>o</mi><mi>h</mi><mi>o</mi><mi>r</mi><msub>
  <mi>t</mi>
  <mi>i</mi>
  </msub>
  
  </mtd>
  </mtr>
  <mtr>
  <mtd>
  <msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>2</mn><mi>i</mi></mrow>
  </msub>
  <mo>=</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>20</mn></mrow>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>21</mn></mrow>
  </msub>
  <mi>c</mi><mi>o</mi><mi>h</mi><mi>o</mi><mi>r</mi><msub>
  <mi>t</mi>
  <mi>i</mi>
  </msub>
  
  </mtd>
  </mtr>
  <mtr>
  <mtd>
  <msub>
  <mi>&#x03B2;</mi>
  <mrow>
  <mn>3</mn><mi>i</mi></mrow>
  </msub>
  <mo>=</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>30</mn></mrow>
  </msub>
  <mo>+</mo><msub>
  <mi>&#x03B3;</mi>
  <mrow>
  <mn>31</mn></mrow>
  </msub>
  <mi>c</mi><mi>o</mi><mi>h</mi><mi>o</mi><mi>r</mi><msub>
  <mi>t</mi>
  <mi>i</mi>
  </msub>
  
  </mtd>
  </mtr>
  </mtable>
  </semantics>
  </math>
  