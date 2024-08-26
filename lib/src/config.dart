class Config {
  static const String appName = "BillingSoft Restaurantes";
  static const String apiURL = '192.168.1.9:8000';

  // APIs para cada modelo
  static const repartidoresAPI = "/api/repartidores";
  static const vehiculosRepartidorAPI = "$apiURL/api/vehiculos-repartidor/";
  static const codigosVerificacionAPI = "$apiURL/api/codigos-verificacion/";
  static const horariosTrabajoAPI = "$apiURL/api/horarios-trabajo/";
  static const historialUbicacionRepartidorAPI = "$apiURL/api/historial-ubicacion-repartidor/";
  static const restaurantesAPI = "$apiURL/api/restaurantes/";
  static const afiliacionesAPI = "$apiURL/api/afiliaciones/";
  static const pedidosAPI = "$apiURL/api/pedidos/";
  static const registrosEstadoPedidoAPI = "$apiURL/api/registros-estado-pedido/";

  // API para pedidos disponibles
  static String pedidosDisponiblesAPI(int repartidorId) => "$apiURL/api/pedidos-disponibles/$repartidorId/";

  // APIs adicionales (asegúrate de que estas rutas existan en tu backend)
  static const loginAPI = "$apiURL/api/login/";
  static const obtenerTokenAPI = "$apiURL/api/api-token-auth/";
}