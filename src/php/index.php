<?php
get_header();
$options = get_fields('options');
?>

<script>
window.__INITIAL_STATE__ = {
    page: {
        sections: <?php echo json_encode(get_field('sections')); ?>,
    },
    options: <?php echo json_encode($options); ?>,
};
</script>

<div id="react-root"></div>

<?php
get_footer();
