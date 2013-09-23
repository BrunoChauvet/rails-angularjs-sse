now = Time.now

ppt = Company.create(code: 'PPT', name: 'Perpetual Limited')
org = Company.create(code: 'ORG', name: 'Origin Energy Limited')
trs = Company.create(code: 'TRS', name: 'The Reject Shop Limited')
flt = Company.create(code: 'FLT', name: 'Flight Center Limited')

Share.create(company: ppt, value: 39.01, timestamp: now - 5.minute)
Share.create(company: ppt, value: 39.59, timestamp: now)

Share.create(company: org, value: 14.03, timestamp: now - 5.minute)
Share.create(company: org, value: 14.45, timestamp: now)

Share.create(company: trs, value: 17.80, timestamp: now - 5.minute)
Share.create(company: trs, value: 18.33, timestamp: now)

Share.create(company: flt, value: 49.80, timestamp: now - 5.minute)
Share.create(company: flt, value: 48.55, timestamp: now)
