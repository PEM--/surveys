Template.survey.rendered = ->
  margin = top: 50, right: 150, bottom: 0, left: 0
  svg_dim = width: 500, height: 200
  graph_dim =
    width: svg_dim.width - margin.left - margin.right
    height: svg_dim.height - margin.top - margin.bottom
  radius = Math.min graph_dim.width, graph_dim.height
  color_range = ['#0F7875', '#19A89D', '#D21B5B', '#9C0B5D']
  color = d3.scale.ordinal().range color_range
  arcs = [
    d3.svg.arc().innerRadius(.8*radius).outerRadius radius
    d3.svg.arc().innerRadius(.6*radius).outerRadius .8*radius
    d3.svg.arc().innerRadius(.4*radius).outerRadius .6*radius
    d3.svg.arc().innerRadius(.2*radius).outerRadius .4*radius
  ]
  pies = [
    d3.layout.pie().sort(null).startAngle(-Math.PI/2).endAngle(Math.PI/2)\
      .value (d) -> d
    d3.layout.pie().sort(null).startAngle(-Math.PI/2).endAngle(Math.PI/2)\
      .value (d) -> d
    d3.layout.pie().sort(null).startAngle(-Math.PI/2).endAngle(Math.PI/2)\
      .value (d) -> d
    d3.layout.pie().sort(null).startAngle(-Math.PI/2).endAngle(Math.PI/2)\
      .value (d) -> d
  ]
  svg = d3.select '[data-chart=\'survey\']'
    .append 'svg:svg'
    .attr 'preserveAspectRatio', 'xMinYMin meet'
    .attr 'viewBox', "0 0 #{svg_dim.width} #{svg_dim.height}"
    .attr 'class', 'd3-svg-content'
  graph = svg.append 'g'
    .attr 'transform', "translate(\
      #{margin.left + graph_dim.width/2},\
      #{margin.top + graph_dim.height})"
  for population, idx in @data.populations
    g = graph
      .selectAll ".arc#{idx}"
      .data pies[idx] population.population.values
      .enter()
        .append 'g'
        .attr 'class', "arc#{idx}"
    g.append 'path'
      .attr 'd', arcs[idx]
      .style 'fill', (d, i) -> color i
  svg.append 'text'
    .attr 'class', 'graph-title'
    .attr 'text-anchor', 'middle'
    .attr 'x', svg_dim.width / 2
    .attr 'y', margin.top/3
    .text @data.name
  svg.append 'text'
    .attr 'class', 'graph-subtitle'
    .attr 'text-anchor', 'middle'
    .attr 'x', svg_dim.width / 2
    .attr 'y', 2*margin.top/3
    .text @data.question
  for d, i in @data.answers
    svg.append 'circle'
      .attr 'style', "stroke: none; fill: #{color(i)};"
      .attr 'r', 4
      .attr 'cx', svg_dim.width - 150
      .attr 'cy', i * 12 + margin.top + 16
    svg.append 'text'
      .attr 'class', 'legend'
      .attr 'x', svg_dim.width - 140
      .attr 'y', i * 12 + margin.top + 20
      .text d
