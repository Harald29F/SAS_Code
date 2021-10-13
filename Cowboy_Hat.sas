/* Graph Template Language that defines the graph layout    */
/* This needs to be run just once within your SAS session   */
/* From Rick's post at:                                     */
/* https://blogs.sas.com/content/iml/create-surface-plot-sas */
proc template;                        /* surface plot with continuous color ramp */
define statgraph SurfaceTmplt;
dynamic _X _Y _Z _Title;              /* dynamic variables */
 begingraph;
 entrytitle _Title;                   /* specify title at run time (optional) */
  layout overlay3d;
    surfaceplotparm x=_X y=_Y z=_Z /  /* specify variables at run time */
       name="surface" 
       surfacetype=fill
       colormodel=threecolorramp      /* or =twocolorramp */
       colorresponse=_Z;
    continuouslegend "surface";
  endlayout;
endgraph;
end;
run;
 
/* DATA step to create the "hat" data */
data hat; 
 do x = -5 to 5 by .5;
  do y = -5 to 5 by .5;
   z = sin(sqrt(y*y + x*x));
   output;
  end;
 end;
run;	
 
ods graphics / width=1000 height=800;
 
/* And... Render the Hat! */
proc sgrender data=hat template=SurfaceTmplt; 
   dynamic _X='X' _Y='Y' _Z='Z' _Title="Howdy Pardner!";
run;