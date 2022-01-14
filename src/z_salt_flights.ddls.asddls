@AbapCatalog.sqlViewName: 'Z__FLIGHTS_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Showing flights'
@OData.publish: true
@Metadata.allowExtensions: true

define view Z_SALT_FLIGHTS

//selecting specific elements from table spfli
as select from spfli as p  

//connects table spfli and sflight based on the same connid and carrid 
association [*] to sflight as _flight
    on $projection.Connid = _flight.connid 
    and $projection.Carrid = _flight.carrid 

//connects table spfli and data definition Z_SALT_BOOKINGS based on the same connid, carrid and flight date  
association [*] to Z_SALT_BOOKINGS as _book
    on $projection.Connid = _book.Connid 
    and $projection.Carrid = _book.Carrid
    and  $projection.FlightDate = _book.FlightDate
    
    {
    
    //association to bookings when clicking on a flight
    @UI.facet: [
    { label: 'Flights', type: #IDENTIFICATION_REFERENCE },
    { label: 'Bookings', type: #LINEITEM_REFERENCE, targetElement: '_book' } 
    ]
    
    @UI: {
       lineItem: [ { position: 10, importance: #HIGH } ],
       identification: [ { position: 10, importance: #HIGH } ]
    }
    key p.carrid as Carrid,
    
    @UI: {
       lineItem: [ { position: 20, importance: #HIGH } ],
       identification: [ { position: 20, importance: #HIGH } ],
       selectionField: [ { position: 20} ]
    }
    key p.connid as Connid,
    
    @UI: {
       lineItem: [ { position: 30, importance: #HIGH } ],
       identification: [ { position: 30, importance: #HIGH } ],
       selectionField: [ { position: 30} ]
    }
    key _flight.fldate as FlightDate,
    
    @UI: {
       lineItem: [ { position: 40, importance: #HIGH } ],
       identification: [ { position: 40, importance: #HIGH } ]
    }
    @EndUserText.label: 'Departure City'
    p.countryfr as Countryfr,
    
    @UI: {
       lineItem: [ { position: 50, importance: #HIGH } ],
       identification: [ { position: 50, importance: #HIGH } ],
       selectionField: [ { position: 50} ]
    }
    p.cityfrom as Cityfrom,
    
    @UI: {
       lineItem: [ { position: 60, importance: #HIGH } ],
       identification: [ { position: 60, importance: #HIGH } ]
    }
    p.airpfrom as Airpfrom,
    
    @UI: {
       lineItem: [ { position: 70, importance: #HIGH } ],
       identification: [ { position: 70, importance: #HIGH } ]
    }
    @EndUserText.label: 'Arrival City'
    p.countryto as Countryto,
    
    @UI: {
       lineItem: [ { position: 80, importance: #HIGH } ],
       identification: [ { position: 80, importance: #HIGH } ],
       selectionField: [ { position: 80} ]
    }
    p.cityto as Cityto,
    
    @UI: {
       lineItem: [ { position: 90, importance: #HIGH } ],
       identification: [ { position: 90, importance: #HIGH } ]
    }
    p.airpto as Airpto,
    
    @UI: {
       lineItem: [ { position: 110, importance: #HIGH } ],
       identification: [ { position: 110, importance: #HIGH } ]
    }
    @EndUserText.label: 'Price'
    _flight.price as Price,
    
    //free seats economy   
    @EndUserText.label: 'Free Seats Economy'
    _flight.seatsmax-_flight.seatsocc as Seatsfree,            
    
    //free seats business
    @EndUserText.label: 'Free Seats Business'
    _flight.seatsmax_b-_flight.seatsocc_b as SeatsfreeBusiness,
    
    //free seats first
    @EndUserText.label: 'Free Seats First'
    _flight.seatsmax_f-_flight.seatsocc_f as SeatsfreeFirst,
    
    @UI: {
       lineItem: [ { position: 120, importance: #HIGH } ],
       identification: [ { position: 120, importance: #HIGH } ]
    }
    p.deptime as Deptime,
    
    @UI: {
       lineItem: [ { position: 200, importance: #HIGH } ],
       identification: [ { position: 200, importance: #HIGH } ]
    }
    p.arrtime as Arrtime,
    
    //total utilization
    @UI: {
       lineItem: [ { position: 210, importance: #HIGH } ],       
       identification: [ { position: 210, importance: #HIGH } ]
    }    
    @EndUserText.label: 'Utilization'
    division((_flight.seatsocc + _flight.seatsocc_b + _flight.seatsocc_f) * 100,
              _flight.seatsmax + _flight.seatsmax_b + _flight.seatsmax_f, 2) as Utilization,
    
    //utilization economy
    @EndUserText.label: 'Utilization Economy'
    division(_flight.seatsocc * 100, _flight.seatsmax, 2) as UtilizationEconomy,
    
    //utilization business
    @EndUserText.label: 'Utilization Business'
    division(_flight.seatsocc_b * 100, _flight.seatsmax_b, 2) as UtilizationBusiness,
    
    //utilization first
    @EndUserText.label: 'Utilization First'
    division(_flight.seatsocc_f * 100, _flight.seatsmax_f, 2) as UtilizationFirst, 
    
    @UI.hidden
    _flight.currency as Currency,
    
    p.distance as Distance,
    
    @UI.hidden
    p.distid as Distid,

    _book, //makes association public
    _flight //makes association public   
}
