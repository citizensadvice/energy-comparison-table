---
layout: page
title: Suppliers
---

<ul>
  {% for supplier in collection.suppliers.resources %}
    <li>
      <a href="/{{ supplier.supplierName }}">{{ resource.data.name }}</a>
    </li>
  {% endfor %}
</ul>
