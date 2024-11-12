//Pagina inicial
js begin
diahora = "[" + new Date().toLocaleString() + "]"
js finish
fallo = false
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


//BUSQUEDA USUARIO MEDIANTE LEGAJO 
type #ef_ei_2261_filtronro_legaj as [clear]`legajo`[enter]
wait 1

if present('#cuadro_2000002_browse0_seleccion')
{
    click #cuadro_2000002_browse0_seleccion    
}
else 
{
    write `diahora` Titulo `#` no cargado.           ERROR Legajo de usuario no encontrado: `legajo` to Error.txt
    fallo = true
}

if fallo == false
{
    // -> Curriculum
    click #ci_2000003_ci_solapas_cambiar_tab_pant_curriculum
    wait 2

    // -> Estudios
    click #ci_1000436_ci_curriculum_cambiar_tab_pant_estudios
    wait 1

    //Agregar estudio
    click #cuadro_1000442_browse_estudios_agregar
    wait 2

    //ACARGA TITULO (Nueva ventana)
    dom document.getElementById("ef_form_1000443_form_estudioscodc_titul_vinculo").click()
    wait 1
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

        //Seleccionar    En caso de no encontrar titulo, devuelve el motivo en el archivo Error.txt
        wait 1
        if present('#cuadro_1000445_browse0_popup')
        {
            click #cuadro_1000445_browse0_popup    
        }
        else 
        {
            write `diahora` Titulo `#` no cargado.           ERROR ID del titulo no encontrado: `titulo` to Error.txt
            fallo = true
            dom window.close()
        }    
}






if fallo == false
{
    //CARGA DE ENTIDAD OTORGANTE
    dom document.getElementById("ef_form_1000443_form_estudioscodc_entot_vinculo").click()
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

        //Seleccionar    En caso de no encontrar titulo, devuelve el motivo en el archivo Error.txt
        wait 1
        if present('#cuadro_1000448_browse0_popup')
        {
            click #cuadro_1000448_browse0_popup    
        }
        else 
        {
            write `diahora` Titulo `#` no cargado.           ERROR ID de la entidad otorgante no encontrado: `entidad_otorgante` to Error.txt
            fallo = true
            dom window.close()
        }
    wait 1
}







if fallo == false
{
    //Carga de titulo ONA
    dom document.getElementById("ef_form_1000443_form_estudiosidtituloona_vinculo").click()

    popup estudiosidtituloona
        wait 1
        //Cargar codigo entidad
        type #ef_ei_45000001_filtroidtitulo as [clear]`titulo_ona`[enter]

        //Abrir submenu
        click #col_ei_45000001_filtroidtitulo

        //Seleccionar es igual a
        select //*[@name="col_ei_45000001_filtroidtitulo"] as es_igual_a

        //Filtrar
        click #ei_45000001_filtro_filtrar

        //Seleccionar    En caso de no encontrar titulo ONA, devuelve el motivo en el archivo Error.txt
        wait 1
        if present('#cuadro_1000451_browse0_popup')
        {
            click #cuadro_1000451_browse0_popup  
        }
        else 
        {
            fallo = true
            write `diahora` Titulo `#` no cargado.           ERROR ID del titulo ONA no encontrado: `titulo_ona` to Error.txt
            dom window.close()
        }
    wait 1
}












if fallo == false
{
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



    //Leer nombre y descripcion del titulo para luego cargar PDF
    read (//*[@id="ef_form_1000443_form_estudioscodc_titul_desc"]) to ititulo
    read (//*[@id="ef_form_1000443_form_estudiosnivel_estudio"]) to nivel

    //Guardar
    click #form_1000443_form_estudios_alta

    // Buscar el titulo recien agregado
    // 1. Iterar tabla
    for (i = 0; i < 5; i++)
    {
        // Obtener el valor de la primer columna de la fila i
        dom_json = i
        dom begin
        return document.querySelectorAll('.ei-cuadro-cuerpo table tr')[dom_json].children[0].innerText.trim()
        dom finish
        w_titulo = dom_result;

        echo w_titulo `w_titulo`
        echo ititulo `ititulo`

        // Comparar el valor obtenido con el valor buscado
        if w_titulo == ititulo
            echo Se encontro el titulo buscado
            dom begin
            return document.querySelectorAll('.ei-cuadro-cuerpo table tr')[dom_json].children[1].innerText.trim()
            dom finish
            w_nivel = dom_result;

            echo w_nivel `w_nivel`
            echo nivel `nivel`

            if w_nivel == nivel
                echo Se encontro el nivel buscado

                // Si se encuentra el valor buscado, hacer click en la fila
                dom begin
                document.querySelectorAll('.ei-cuadro-cuerpo table tr')[dom_json].querySelector("button").click()
                dom finish
                break
            else
                echo No se encontro el nivel buscado
        else
            echo No se encontro el titulo buscado
    }

    wait 2


    //Cargar pdf
    click #form_1000443_form_estudios_dig_estudio

    popup 54000008
        wait 1
        click #ef_form_54000010_form_digitalizacionesarchivo
        wait 4
        keyboard `pdf`[enter]

        click #form_54000010_form_digitalizaciones_agregar
        wait 2
        dom window.close()
}
















