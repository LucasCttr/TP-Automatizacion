//Pagina inicial 

if iteration == 1 

    https://mapuche.siu.edu.ar/mapuche/aplicacion.php?fs=1
    wait 3

    //Carga de datos del LogIn
    type #ef_form_30000188_datosusuario as demo
    type #ef_form_30000188_datosclave as demo
    click button[type="submit"]
    wait 3

    //Boton de menu [menu -> legajo]
    click #boton_menu_raiz
    click #elemento_menu_2000002
    click #elemento_menu_2000004
    wait 3
    
else

    https://mapuche.siu.edu.ar/mapuche/aplicacion.php?tm=1&tcm=central&ai=mapuche||2000004

//Carga de los legajos desde el excel 
type #ef_ei_2261_filtronro_legaj as [clear]`legajo`[enter]
wait 1
click #cuadro_2000002_browse0_seleccion

// -> Curriculum
click #ci_2000003_ci_solapas_cambiar_tab_pant_curriculum
wait 2

// -> Estudios
click #ci_1000436_ci_curriculum_cambiar_tab_pant_estudios
wait 1

//Agregar estudio
click #cuadro_1000442_browse_estudios_agregar
wait 2


//DATOS A COMPLETAR
type #ef_form_1000443_form_estudiosfec_emisi as [clear]`fecha_emision`

type #ef_form_1000443_form_estudioscant_anos as [clear]`fecha_emision_años`

type #ef_form_1000443_form_estudioscant_meses as [clear]`fecha_emision_meses`

wait 1
if "`con_tesis`" equals to "si"
    click #ef_form_1000443_form_estudiossino_tesis0
else
    click #ef_form_1000443_form_estudiossino_tesis1
wait 2

js begin
mes = new Date().getMonth() + 1;
año =  new Date().getFullYear();
js finish

//Carga de mes actual
echo `mes`
echo `año`
type #ef_form_1000443_form_estudiosmes_financ as `mes`
type #ef_form_1000443_form_estudiosanio_financ as `año`

//ACARGA TITULO (Nueva ventana)
click #ef_form_1000443_form_estudioscodc_titul_vinculo
wait 3

//Selecciona 1 titulo 
popup ef_popup_valor
    wait 1
    type #ef_ei_6000244_filtrocodc_titul as [clear]`titulo`[enter]

    //Abrir submenu
    click #col_ei_6000244_filtrocodc_titul 

    //Seleccionar es igual a
    click option[value="es_igual_a"]
    select //*[@name="col_ei_6000244_filtrocodc_titul"] as es_igual_a

    //Filtrar
    click #ei_6000244_filtro_filtrar

    //Seleccionar
    click #cuadro_1000445_browse0_popup


//CARGA DE ENTIDAD OTORGANTE
click #ef_form_1000443_form_estudioscodc_entot_vinculo
wait 1

popup ef_popup_valor
    wait 1 
    //Cargar codigo entidad
    type #ef_ei_6000245_filtrocodc_entot as [clear]`entidad_otorgante`[enter]

    //Abrir submenu
    click #col_ei_6000245_filtrocodc_entot 

    //Seleccionar es igual a
    click option[value="es_igual_a"]
    select //*[@name="col_ei_6000245_filtrocodc_entot"] as es_igual_a

    //Filtrar
    click #ei_6000245_filtro_filtrar

    //Seleccionar
    click #cuadro_1000448_browse0_popup
wait 1


//Guardar
click #form_1000443_form_estudios_alta 
