<script>
import axios from "axios";
export default {
  data() {
    return {
      loading: false,
      name: {
        alias: "Your Name",
        value: null,
      },
    };
  },
  methods: {
    async create() {
      axios
        .post("http://localhost:3000/guests", {
          name: this.name.value,
        })
        .then((response) => {
          if (response.data.status == "success") {
            this.loading = false;
            this.$notify({
              type: "success",
              title: "Success",
              message: "Created",
              position: "bottom-right",
            });
            this.$router.push(`${response.data.guest.id}/room`);
          }
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
  },
};
</script>
<template>
  <div class="flex justify-center">
    <div class="block max-w-sm rounded-lg bg-white p-6 shadow-lg">
      <p
        class="mb-2 text-xl font-medium leading-tight text-neutral-800"
      >
        Welcome to Chat App!
      </p>
      <p class="mb-4 text-base text-neutral-600">Enter your name!</p>
      <el-input
        class="my-3"
        prop="name"
        :disabled="loading"
        v-model="name.value"
        :placeholder="name.alias"
      />
      <button
        type="button"
        class="inline-block rounded border-0 px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal bg-sky-300 hover:bg-sky-400"
        :disabled="!name.value || loading"
        @click="create()"
      >
        Start
      </button>
    </div>
  </div>
</template>
