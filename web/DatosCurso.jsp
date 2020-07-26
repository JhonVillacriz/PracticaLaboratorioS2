

<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Curso</title>
        <h1><i class="titulo">Datos Curso</i></h1> 
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        
        <%!
            // Variables globales (Página)
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idcurso;
            String s_nombre;
            String s_horas;
            String s_creditos;
            String s_codigo;
            String s_estado;

        %>
    </head>
    <body>
        
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idcurso = request.getParameter("f_idcurso");
                // Primera parte del modificar
                if (s_accion!=null && s_accion.equals("M1")) {
                    consulta =  "   select codigo, nombre, horas, creditos, estado  "
                                + " from curso  "
                                + " where  "
                                + " idcurso =  " + s_idcurso;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                            
                        
                    %>    
                <form name="EditarCursoForm" action="DatosCurso.jsp" method="GET">
                    <table border="0" align="center" class="azulino" style="margin: auto; display: table">
                        <thead>
                            <tr>
                                <th colspan="2">Editar Curso</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Codigo:</td>
                                <td><input type="text" name="f_codigo" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25" /></td>
                            </tr>
                            <tr>
                                <td>Nombre:</td>
                                <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                            </tr>
                            <tr>
                                <td>Horas: </td>
                                <td><input type="text" name="f_horas" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8" /></td>
                            </tr>
                            <tr>
                                <td>Creditos: </td>
                                <td><input type="text" name="f_creditos" value="<% out.print(rs.getString(4)); %>" maxlength="12" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Estado: </td>
                                <td><input type="text" name="f_estado" value="<% out.print(rs.getString(5)); %>" maxlength="1" size="2" /></td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <input type="submit" value="Editar" name="f_editar" />
                                    <input type="hidden" name="f_accion" value="M2" />
                                    <input type="hidden" name="f_idcurso" value="<%out.print(s_idcurso);%>" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                 <br>
                <br>
                    
                    <%
                        }
                }else{
                // Si no se hace la primera parte del modidicar debe mostrar el 
                // formulario de agregar estudiante

        %>
        <form name="AgregarCursoForm" action="DatosCurso.jsp" method="GET">
            <table border="0" align="center" class="azulino" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Curso</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Codigo:</td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="25" /></td>
                    </tr>
                    <tr>
                        <td>Nombre:</td>
                        <td><input type="text" name="f_apellidos" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Horas: </td>
                        <td><input type="text" name="f_dni" value=""maxlength="8" size="8" /></td>
                    </tr>
                    <tr>
                        <td>Creditos: </td>
                        <td><input type="text" name="f_codigo" value="" maxlength="12" size="15" /></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="" maxlength="1" size="2" /></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                            
                        
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            }
        %>
        <br>
        <br>
        <table border="2" align="center" class="azulino" style="margin: auto; display: table" >
            <thead>
                <tr>
                    <th colspan="8">
                        Datos Curso
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Codigo</th>
                    <th>Nombre</th>
                    <th>Horas</th>
                    <th>Creditos</th>
                    <th>Estado</th>
                    <th colspan="2">Acciones</th>

                </tr>
            </thead>

        
        <%        
                
                
                if (s_accion !=null) {
                    
                    // Ejecutar la eliminación de estudiantes
                    if (s_accion.equals("E")) {
                            consulta =    " delete from curso "
                                        + " where  "
                                        + " idcurso = " + s_idcurso +"; ";
                            out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")){
                            s_codigo = request.getParameter("f_codigo");
                            s_nombre = request.getParameter("f_nombre");
                            s_horas = request.getParameter("f_horas");
                            s_creditos = request.getParameter("f_creditos");
                            s_estado = request.getParameter("f_estado");
                            
                            consulta =    " insert into "
                                        + " curso (codigo, nombre, horas, creditos, estado)"
                                        + " values('"+ s_codigo +"','"+ s_nombre +"','"+ s_horas +"','"+ s_creditos +"','"+s_estado+"');  ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                            s_codigo = request.getParameter("f_codigo");
                            s_nombre = request.getParameter("f_nombre");
                            s_horas = request.getParameter("f_horas");
                            s_creditos = request.getParameter("f_creditos");
                            s_estado = request.getParameter("f_estado");
                            consulta =  "   update curso  "
                                        + " set "
                                        + " codigo = '"+ s_codigo +"', "
                                        + " nombre = '" + s_nombre + "', "
                                        + " horas = '" + s_horas + "', "
                                        + " creditos = '" + s_creditos + "', "
                                        + " estado = '" + s_estado + "'  "
                                        + " where  "
                                        + " idcurso = " + s_idcurso + "; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }
                    
                }
                
                // Listar los estudiantes de la TABLA ESTUDIANTE
                consulta= " Select idcurso, codigo, nombre, horas, creditos, estado "
                        + " from curso ";
                //out.print(consulta);
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                while (rs.next()) {    
                    ide = rs.getString(1);
                    num++;
                    %>
                    <tbody>
                    <tr>
                        <td><%out.print(num);%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><%out.print(rs.getString(5));%></td>
                        <td><%out.print(rs.getString(6));%></td>
                        <td><a href="DatosCurso.jsp?f_accion=E&f_idcurso=<%out.print(ide);%>"><img src="img/eliminar_25x25.png"  /></a></td>
                        <td><a href="DatosCurso.jsp?f_accion=M1&f_idcurso=<%out.print(ide);%>"><img src="img/editar_25x25.png"  /></a></td>
                        
                    </tr>                    
                    <%
                    }
                    // Se cierra todas las conexiones
                    rs.close();
                    pst.close();
                    cn.close();
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        <tr align="center">
                <td colspan="8"><a href="menu.jsp"> <input type="submit" value="Menú" /> </a>
                       </td>
                </tr>
            
            </tbody>
        </table>
    </body>
</html>
