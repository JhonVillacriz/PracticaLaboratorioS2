

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1><i>PracticaLaboratorio</i></h1>
        <table border="2"  align="center" class="azulino" style="margin: auto; display: table">
            <thead>
                
                    <th colspan="2">MENU ESTUDIANTE</th>               
                </tr>
            </thead>
            <tbody>
                <tr><td><center><input type="button" value="Datos Estudiante" onclick="location.href='datosestudiante.jsp'" /></td> </tr>
                <tr><td><center><input type="button" value="Datos Curso" onclick="location.href='DatosCurso.jsp'" /></td> </tr>            
                <tr><td><center><input type="button" value="Datos Carrera" onclick="location.href='DatosCarrera.jsp'" /></td> </tr> 
                <tr><td><center><input type="button" value="Datos Matrícula" onclick="location.href='DatosMatricula.jsp'" /></td> </tr> 
               <tr align="center">
                <td><a href="salida.jsp"> <input type="submit" value="salir" /> </a>
                       </td>
                </tr>
            </tbody>
        </table>
 
    </body>
</html>
