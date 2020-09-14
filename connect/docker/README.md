
# Installation

* In order to access oracle from the JDBC Source and Sink Connectors, the oracle driver needs to be installed within the
jdbc plugin. 

* Oracle does not provide a way to download this client jar w/out authentication.

* Download the jar from oracle, and place in the ./downloads directory so it can be added to the plugin when this container is build.

  * Select `ojdbc7.jar` from this website, you will be redirected to authenticate againt an oracle account (which you can obtain for free)
and accept their terms.

    * `https://www.oracle.com/database/technologies/jdbc-drivers-12c-downloads.html`

  * The direct link (which you could access if you are authenticated).
  
    * `https://download.oracle.com/otn/utilities_drivers/jdbc/121010/ojdbc7.jar`

