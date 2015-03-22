Template.survey.rendered = ->
  console.log @data
  margin = top: 10, right: 10, bottom: 10, left: 10
  svg = width: 400, height: 200
  graph_dim =
    width: svg.width - margin.left - margin.right
    height: svg.height - margin.top - margin.bottom
  radius = Math.min graph_dim.width, graph_dim.height
  color = d3.scale.ordinal()
    .range ['#1cb22d', '#b2ae1b', '#b26c1b', '#b21b1b']
  arc = d3.svg.arc()
    .innerRadius .8 * radius
    .outerRadius radius
  pie = d3.layout.pie()
    .sort null
    .startAngle -Math.PI/2
    .endAngle Math.PI/2
    .value (d) -> d
  graph = d3.select '[data-chart=\'survey\']'
    .append 'svg:svg'
    .attr 'preserveAspectRatio', 'xMinYMin meet'
    .attr 'viewBox', "0 0 #{svg.width} #{svg.height}"
    .attr 'class', 'd3-svg-content'
    .append 'g'
    .attr 'transform', "translate(\
      #{margin.left + graph_dim.width/2},\
      #{margin.top + graph_dim.height})"
  g = graph
    .selectAll '.arc'
    .data pie @data.populations[0].population.values
    .enter()
      .append 'g'
      .attr 'class', 'arc'
  g.append 'path'
    .attr 'd', arc
    .style 'fill', (d, i) -> color i
