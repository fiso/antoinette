<?php
get_header();
?>

<script>
window.__INITIAL_STATE__ = {
    page: {
        is404: true,
    },
    options: <?php echo json_encode(get_fields('options')); ?>,
};
</script>

<div id="react-root"></div>

<?php
get_footer();
