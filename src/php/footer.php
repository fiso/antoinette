<?php
$staticBasePath = get_static_base_path();
?>
<?php wp_footer(); ?>
<% for (var chunk in htmlWebpackPlugin.files.chunks) { %>
        <script src="<?php echo $staticBasePath; ?>/<%= htmlWebpackPlugin.files.chunks[chunk].entry %>"></script>
<% } %>
    </body>
</html>
