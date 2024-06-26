#!/usr/bin/env bash

cd "$(dirname "$0")"

DST="${1:-data.example.yml}"
FONTS_PATH="${2:-$(pwd)/fonts}"
FONT_NAME="${3:-Ubuntu}"
cat << EOF > "$DST"
---
fonts_path: '$FONTS_PATH'
font: '$FONT_NAME'
fontsize: '10pt'
geometry: 'left=20mm,right=20mm,top=20mm,bottom=20mm'

invoice-number: '00001'
date: '31/01/2022'

from:
  name: 'Bertram Gilfoyle'
  contact-details:
    - '10 Employee Street'
    - 'City'
    - 'State'
    - 'Postcode'
    - 'Country'
    -
    - 'gilfoyle@piedpiper.com'
    - '(+357) 123-456789'
  tax-identification-number: 'CY12345678X'
  vat-registration-number: 'CY12345678X'
  bank-details:
    name: 'Bank For Your Buck'
    address: '10 Money Street, City, State, Postcode, Country'
    account-number: '000-123-4'
    iban: 'CY00000000000000000000001234'
    swift: 'ABCDEFGH'

to:
  name: 'Aviato'
  vat-registration-number: 'IT12345678901'
  address:
    - '10 Company Street'
    - 'City'
    - 'State'
    - 'Postcode'
    - 'Country'

currency: '€'
vat-rate: 20

services:
  - description: 'Consultancy services'
    hourly:
      hours: 160
      rate: 10.00
  - description: 'Used Anton'
    hourly:
      hours: 10.5
      rate: 100.00
  - description: 'Bonus'
    other:
      price: 100.00
  - description: 'Expense \#1'
    other:
      price: 1000.00
      details: 'Acquired equipment (attached invoice with number 123456789)'
  - description: 'Expense \#2'
    other:
      price: 10.00
      details: 'Ate pizza (receipt attached)'
  - description: 'Expense \#3'
    other:
      price: 150.00
      details: 'Travelled to conference (receipts attached)'
---
EOF
