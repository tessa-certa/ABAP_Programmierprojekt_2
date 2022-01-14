@AbapCatalog.sqlViewName: 'Z_BOOKINGS_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Showing bookings by Miles and More'

define view Z_SALT_BOOKINGS as select from sbook
{
    @UI.hidden
    key carrid as Carrid,

    @UI.hidden
    key connid as Connid,
    
    @UI.hidden
    key fldate as FlightDate,
    
    @UI: {
       lineItem: [ { position: 10, importance: #HIGH } ],
       identification: [ { position: 10, importance: #HIGH } ]
    }
    key bookid as Bookid,
    
    @UI: {
       lineItem: [ { position: 20, importance: #HIGH } ],
       identification: [ { position: 20, importance: #HIGH } ]
    }
    customid as Customid,
    
    @UI: {
       lineItem: [ { position: 30, importance: #HIGH } ],
       identification: [ { position: 30, importance: #HIGH } ]
    }
    custtype as Custtype,
    
    @UI: {
       lineItem: [ { position: 40, importance: #HIGH } ],
       identification: [ { position: 40, importance: #HIGH } ]
    }
    class as Class,
    
    @UI: {
       lineItem: [ { position: 50, importance: #HIGH } ],
       identification: [ { position: 50, importance: #HIGH } ]
    }
    luggweight as Luggweight,
    
    @UI.hidden
    wunit as Wunit,
    
    @UI: {
       lineItem: [ { position: 60, importance: #HIGH } ],
       identification: [ { position: 60, importance: #HIGH } ]
    }
    passname as Passname,
    
    @UI.hidden
    invoice as Invoice,
    
    @UI: {
       lineItem: [ { position: 70, importance: #HIGH } ],
       identification: [ { position: 70, importance: #HIGH } ]
    }
    order_date as OrderDate,
    
    @UI: {
       lineItem: [ { position: 80, importance: #HIGH } ],
       identification: [ { position: 80, importance: #HIGH } ]
    }
    smoker as Smoker,
    
    forcuram as Forcuram,
    forcurkey as Forcurkey,
    loccuram as Loccuram,
    loccurkey as Loccurkey, 
    passbirth as Passbirth,
    
    @UI.hidden
    agencynum
        
} where cancelled <> 'X'
