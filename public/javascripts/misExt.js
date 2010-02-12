		
var App = new Ext.App({});
Ext.QuickTips.init()

Ext.data.DataProxy.addListener('beforewrite', function(proxy, action) {
	App.setAlert(null,"Espere por favor...");

	//App.setAlert(App.STATUS_NOTICE, "Before " + action);
});

Ext.data.DataProxy.addListener('write', function(proxy, action, result, res, rs) {
    //App.setAlert(true, action + ':' + res.message);
    App.setAlert("Aviso", res.message);
});

Ext.data.DataProxy.addListener('exception', function(proxy, type, action, options, res) {
    App.setAlert(false, "Hubo un error con la siguiente funcion: " + action);
});



Ext.ns("Ext.ux");

Ext.ux.MenuSitio = Ext.extend(Ext.Toolbar,{
	constructor: function(config){
		

		Ext.apply(this,{
			autoWidth		: true,
			renderTo		: 'menu'
		});
		Ext.ux.MenuSitio.superclass.constructor.apply(this, arguments);
	}
	
});



Ext.ux.HerramientasGrid = Ext.extend(Ext.Toolbar,{
	constructor: function(config){
		this.onNew = function(){ location.href = this.modeloUrl+"/new" };
		this.onEdit = function(){
			var seleccion = this.ownerCt.getSelectionModel().getSelected();
			if (seleccion) {
				location.href = this.modeloUrl+"/"+seleccion.data.id+"/edit"
			} else {
				alert ("Tiene que seleccionar un registro primero")
			}
		}
		this.onDestroy = function(){
			
			Ext.Msg.confirm( 'Confirmar','Esta seguro?',function(btn){
				if (btn=="yes"){
					var grid = this.ownerCt;
					var seleccion = grid.getSelectionModel().getSelected();
					if (!seleccion) { return false};
					grid.store.remove(seleccion);
					grid.store.reload();
				}
				},this);
			

		};
		
		Ext.apply(this,{

			autoWidth:  true,
			items	:  [{
					text: "Nuevo",
					scope: this,
					handler: this.onNew
					},"-",{
					text: "Editar",
					scope: this,
					handler: this.onEdit
					},"-",{
						text		: "Eliminar",
						scope	: this,
						handler	: this.onDestroy
					}]
		});
		
		Ext.ux.HerramientasGrid.superclass.constructor.apply(this, arguments);	
	}
});

Ext.ux.ToolbarPaginacion = Ext.extend(Ext.PagingToolbar,{
	constructor: function(){
		Ext.apply(this,{
			pageSize					: 10,
			displayInfo				: true,
			displayMsg				: 'Mostrando {0} - {1} registros de {2}',
            emptyMsg					: "No hay registros para mostrar",
			beforePageText		: "Pagina",
			afterPageText			: "de {0}",
			firstText					: "Primera Pagina",
			lastText					: "Ultima Pagina",
			prevText					: "Pagina Anterior",
			nextText					: "Pagina Siguiente",
			refreshText				: "Recargar"
			
		});
		
		Ext.ux.ToolbarPaginacion.superclass.constructor.apply(this, arguments);
	}
});

Ext.ux.JsonReader = function(config) {
	return new Ext.data.JsonReader(Ext.apply({
			root						: 'datos',
			totalProperty			: 'total',
	    	successProperty		: 'success',
	    	messageProperty	: 'message',
			idProperty				: 'id'
		
		}, config));
};
Ext.extend(Ext.ux.JsonReader, Ext.data.JsonReader);

/* ################### GRID PRECONFIGURADO  ###############*/

Ext.ux.GridPanel = Ext.extend(Ext.grid.GridPanel,{
	initComponent: function(){
		
		Ext.apply(this, {
			id		: this.controlador+"Grid",
			viewConfig	: {forceFit:true},
			//width			: 600,
			autoWidth		: true,
			height			: 317,
			loadMask		: {msg:"Cargando..."},
			stripeRows	: true,
			sm: new Ext.grid.RowSelectionModel({singleSelect:true})
		});
		
		Ext.ux.GridPanel.superclass.initComponent.apply(this, arguments);
		}
	});
	
/* ################### PANEL DE PRODUCTOS  ###############*/

Ext.ux.PanelProductos = Ext.extend(Ext.Panel,{

	initComponent: function(){
		
		this.grid = new Ext.ux.GridPanel({
			region	: 'north',
			split		: true,
			controlador: "productos",
			store: com.vd.productos.store,
			cm	: com.vd.productos.columnas,
			tbar	: new Ext.ux.HerramientasGrid({ 
				border		: false,
				frame		: false,
				modeloUrl	: this.modeloUrl
				
			}),
			fbar	: new Ext.ux.ToolbarPaginacion({
				store		: com.vd.productos.store,
				border	: false,
				frame	: false
				
			})
		});
		this.detalleTemplate = new Ext.Template([
			'<strong>Detalle:</strong> {detalle}'

		]);
		this.grid.getSelectionModel().on('rowselect',function(sm,index,rec){

			this.detalleTemplate.overwrite(this.panelDetalle.body,rec.data);
		},this);
		
		
		this.panelDetalle = new Ext.Panel({
			region		: 'center',
			height		: 60,
			autoScroll	: true,
			bodyStyle	: {
					background: '#ffffff',
					padding: '7px'
				},
			html		: "Haga click en un producto para ver su detalle."
		});
		
		Ext.apply(this, {
			renderTo	: 'x-productos',
			title			: "Productos",
			frame		: true,
			width		: 600,
			height		: 500,
			layout		: 'border',
			items		: [
				this.grid,this.panelDetalle
			]
		});
		Ext.ux.PanelProductos.superclass.initComponent.apply(this, arguments);
	}
});


/* ################### PANEL DE CATEGORIAS  ###############*/


Ext.ux.PanelCategorias = Ext.extend(Ext.Panel,{
	
	initComponent: function(){
		this.gridCategorias = new Ext.ux.GridPanel({
			region			: 'center',
			split				: true,
			controlador	: 'categorias',
			store				: com.vd.categorias.store,		
			cm				: new Ext.grid.ColumnModel({
				defaults: {
					width: 120,
					sortable: true
				},
				columns: [
					{id: 'id', header: 'Id', dataIndex:'id',width: 10},
					{header: "Nombre", dataIndex: "nombre"}
				]
			}),
            tbar	: new Ext.ux.HerramientasGrid({
				border		: false,
				frame		: false,
				modeloUrl	: this.modeloUrl
			})
		});
		
		Ext.apply(this,{
			renderTo: 'x-categorias',
			title		: "Categorias",
			width	: 500,
			height	: 300,
			frame	: true,
			layout	: 'border',

			items	: [this.gridCategorias]
			
		});
		Ext.ux.PanelCategorias.superclass.initComponent.apply(this, arguments);
	}
});
